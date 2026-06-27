#!/bin/sh

. /lib/functions.sh
. /lib/functions/network.sh

LAST_RELOAD=0
RELOAD_COOLDOWN=60

log() {
	local level="$1"
	local msg="$2"
	local cfg_level=$(uci -q get wifi-monitor.config.log_level || echo "1")
	if [ "$level" -le "$cfg_level" ]; then
		logger -t "wifi-monitor" "[$level] $msg"
		echo "[$level] $msg"
	fi
}

# Timestamp in seconds since epoch (cross-platform: busybox date)
now_ts() {
	date +%s 2>/dev/null || echo 0
}

# Safe wifi reload with cooldown
safe_reload() {
	local now=$(now_ts)
	local elapsed=$((now - LAST_RELOAD))
	if [ "$elapsed" -lt "$RELOAD_COOLDOWN" ]; then
		log 1 "Skipping wifi reload: only ${elapsed}s since last reload (cooldown=${RELOAD_COOLDOWN}s)"
		return 0
	fi
	log 1 "Triggering wifi reload..."
	wifi reload
	LAST_RELOAD="$now"
}

# Collect all STA interfaces on the monitored radio
find_sta_ifaces() {
	local cfg="$1"
	local mode device disabled
	config_get mode "$cfg" mode
	config_get device "$cfg" device
	config_get disabled "$cfg" disabled "0"
	if [ "$mode" = "sta" ] && [ "$device" = "$radio" ] && [ "$disabled" != "1" ]; then
		sta_cfg_ids="${sta_cfg_ids}${sta_cfg_ids:+ }$cfg"
	fi
}

# Collect all AP interfaces on the monitored radio
find_ap_ifaces() {
	local cfg="$1"
	local mode device disabled
	config_get mode "$cfg" mode
	config_get device "$cfg" device
	config_get disabled "$cfg" disabled "0"
	if [ "$mode" = "ap" ] && [ "$device" = "$radio" ] && [ "$disabled" != "1" ]; then
		ap_cfg_ids="${ap_cfg_ids}${ap_cfg_ids:+ }$cfg"
	fi
}

# Get dynamic OS interface name (e.g. wlan0-1) for a UCI wireless section using ubus
get_ifname() {
	local radio="$1"
	local section="$2"
	ubus call network.wireless status 2>/dev/null | jsonfilter -e "@['$radio'].interfaces[@.section='$section'].ifname" 2>/dev/null
}

# Check if a wireless interface is up according to netifd
is_iface_up() {
	local radio="$1"
	local section="$2"
	local state=$(ubus call network.wireless status 2>/dev/null | jsonfilter -e "@['$radio'].interfaces[@.section='$section'].up" 2>/dev/null)
	[ "$state" = "true" ]
}

# Check if a STA interface is connected (has valid BSSID)
is_sta_connected() {
	local ifname="$1"
	local ap_mac=$(iwinfo "$ifname" info 2>/dev/null | grep "Access Point:" | awk '{print $3}')
	[ -n "$ap_mac" ] && [ "$ap_mac" != "00:00:00:00:00:00" ] && [ "$ap_mac" != "Not-Associated" ]
}

# Get the channel a STA is operating on
get_sta_channel() {
	local ifname="$1"
	iwinfo "$ifname" info 2>/dev/null | grep -i "Channel:" | sed -n 's/.*Channel: \([0-9]*\).*/\1/p'
}

# Check if all AP interfaces on the radio are up
all_ap_up() {
	local ap
	for ap in $ap_cfg_ids; do
		if ! is_iface_up "$radio" "$ap"; then
			return 1
		fi
	done
	return 0
}

# Main loop
while true; do
	# Re-read configuration settings on each iteration to support hot-reloading
	enabled=$(uci -q get wifi-monitor.config.enabled || echo "0")
	if [ "$enabled" -ne 1 ]; then
		log 1 "Service has been disabled. Exiting."
		exit 0
	fi

	interval=$(uci -q get wifi-monitor.config.interval || echo "30")
	radio=$(uci -q get wifi-monitor.config.radio || echo "radio0")
	target_sta=$(uci -q get wifi-monitor.config.sta || echo "")
	scan_disable_ap=$(uci -q get wifi-monitor.config.scan_disable_ap || echo "0")

	config_load wireless
	sta_cfg_ids=""
	ap_cfg_ids=""
	config_foreach find_sta_ifaces wifi-iface
	config_foreach find_ap_ifaces wifi-iface

	if [ -z "$sta_cfg_ids" ]; then
		log 1 "No active STA interface configured on $radio. Sleeping..."
		sleep "$interval"
		continue
	fi

	# If a specific STA is configured, only monitor that one
	if [ -n "$target_sta" ]; then
		# Verify the configured STA actually exists
		local found=0
		for sta in $sta_cfg_ids; do
			[ "$sta" = "$target_sta" ] && found=1
		done
		if [ "$found" -eq 0 ]; then
			log 0 "Configured STA '$target_sta' not found among active STAs ($sta_cfg_ids). Check config."
			sleep "$interval"
			continue
		fi
		sta_cfg_ids="$target_sta"
	fi

	# Warn if multiple STAs exist on same radio (known mt76/wpa_supplicant issue)
	sta_count=$(echo "$sta_cfg_ids" | wc -w)
	if [ "$sta_count" -gt 1 ]; then
		log 0 "WARNING: $sta_count STA interfaces on $radio ($sta_cfg_ids)."
		log 0 "Multiple STAs on the same radio can cause wpa_supplicant to deinit"
		log 0 "the entire radio, disrupting AP interfaces. Set 'sta' option to monitor only one."
	fi

	# Find the first connected STA; fall back to the first configured STA
	primary_sta=""
	primary_ifname=""
	for sta in $sta_cfg_ids; do
		local ifname=$(get_ifname "$radio" "$sta")
		if [ -n "$ifname" ] && is_sta_connected "$ifname"; then
			primary_sta="$sta"
			primary_ifname="$ifname"
			break
		fi
		if [ -z "$primary_sta" ] && [ -n "$ifname" ]; then
			primary_sta="$sta"
			primary_ifname="$ifname"
		fi
	done

	# If no STA was found connected, use the first one
	if [ -z "$primary_sta" ]; then
		primary_sta="${sta_cfg_ids%% *}"
		primary_ifname=$(get_ifname "$radio" "$primary_sta")
	fi

	if [ -z "$primary_ifname" ]; then
		log 2 "No STA interface created yet for any configured STA on $radio. Waiting..."
		sleep "$interval"
		continue
	fi

	log 2 "Monitoring STA: $primary_sta ($primary_ifname) on $radio, total STAs: $sta_count, APs: $ap_cfg_ids"

	# ============================================================
	# SCENARIO B: STA is connected
	# ============================================================
	if is_sta_connected "$primary_ifname"; then
		actual_chan=$(get_sta_channel "$primary_ifname")
		configured_chan=$(uci -q get wireless."$radio".channel || echo "auto")

		# Check if AP interfaces are up
		if ! all_ap_up; then
			log 1 "One or more AP interfaces are DOWN on $radio while STA $primary_ifname is connected."
			log 1 "STA is on channel $actual_chan. Syncing UCI and reloading..."
			if [ -n "$actual_chan" ]; then
				uci set wireless."$radio".channel="$actual_chan"
				uci commit wireless
			fi
			safe_reload
		elif [ -n "$actual_chan" ] && [ "$configured_chan" != "auto" ] && [ "$configured_chan" != "$actual_chan" ]; then
			# Channel mismatch but AP is healthy.
			# On a shared radio, STA determines the channel. Just sync UCI without reload
			# to avoid disrupting the connection. A reload is unnecessary here.
			log 2 "Channel sync: UCI=$configured_chan, actual=$actual_chan. Updating UCI only (AP is healthy, no reload needed)."
			uci set wireless."$radio".channel="$actual_chan"
			uci commit wireless
		else
			log 2 "STA $primary_ifname connected on channel $actual_chan. AP state healthy."
		fi

	# ============================================================
	# SCENARIO A: STA is disconnected
	# ============================================================
	else
		log 1 "STA $primary_ifname ($primary_sta) is disconnected. Attempting recovery..."

		# Get configured SSID & BSSID
		config_get ssid "$primary_sta" ssid
		config_get bssid "$primary_sta" bssid

		# 1. Optionally disable local AP for clean scanning
		if [ "$scan_disable_ap" -eq 1 ] && [ -n "$ap_cfg_ids" ]; then
			log 1 "Temporarily disabling AP interfaces for clean scanning..."
			for ap_cfg in $ap_cfg_ids; do
				uci set wireless."$ap_cfg".disabled='1'
			done
			uci commit wireless
			safe_reload
			sleep 5
			# Re-discover interface name after reload
			primary_ifname=$(get_ifname "$radio" "$primary_sta")
		fi

		# 2. Perform scan to find the upstream channel
		scan_results=""
		if [ -n "$primary_ifname" ]; then
			log 2 "Scanning for upstream AP (SSID: $ssid, BSSID: $bssid) on $primary_ifname..."
			scan_results=$(iwinfo "$primary_ifname" scan 2>/dev/null)
		else
			log 1 "STA interface is down or not created yet. Skipping scan."
		fi

		target_chan=$(echo "$scan_results" | awk -v bssid="$bssid" -v ssid="$ssid" '
			tolower($0) ~ /address:/ {
				mac = tolower($NF)
			}
			$0 ~ /ESSID:/ {
				split($0, a, "\"")
				ess = a[2]
			}
			$0 ~ /Channel:/ {
				for(i=1; i<=NF; i++) {
					if($i == "Channel:") {
						chan = $(i+1)
						break
					}
				}
				if (bssid != "" && mac == tolower(bssid)) {
					print chan
					exit
				}
				if (bssid == "" && ess == ssid) {
					print chan
					exit
				}
			}
		')

		# 3. Restore AP interfaces if they were disabled
		if [ "$scan_disable_ap" -eq 1 ] && [ -n "$ap_cfg_ids" ]; then
			log 1 "Restoring AP interfaces in configuration..."
			for ap_cfg in $ap_cfg_ids; do
				uci set wireless."$ap_cfg".disabled='0'
			done
			uci commit wireless
		fi

		if [ -n "$target_chan" ]; then
			cur_chan=$(uci -q get wireless."$radio".channel || echo "auto")
			if [ "$cur_chan" != "$target_chan" ] || [ "$scan_disable_ap" -eq 1 ]; then
				log 1 "Upstream AP found on channel $target_chan (UCI: $cur_chan). Syncing and reloading..."
				uci set wireless."$radio".channel="$target_chan"
				uci commit wireless
				safe_reload
			else
				log 2 "Upstream AP already on configured channel ($cur_chan). Waiting for wpa_supplicant to reconnect..."
			fi
		else
			log 1 "Upstream AP ($ssid / $bssid) not found in scan results."
			if [ "$scan_disable_ap" -eq 1 ]; then
				log 1 "Reloading wireless stack to restore AP interfaces..."
				safe_reload
			fi
		fi
	fi

	sleep "$interval"
done
