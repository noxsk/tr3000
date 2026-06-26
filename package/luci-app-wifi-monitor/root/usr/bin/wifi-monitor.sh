#!/bin/sh

. /lib/functions.sh
. /lib/functions/network.sh

log() {
	local level="$1"
	local msg="$2"
	local cfg_level=$(uci -q get wifi-monitor.config.log_level || echo "1")
	if [ "$level" -le "$cfg_level" ]; then
		logger -t "wifi-monitor" "[$level] $msg"
		echo "[$level] $msg"
	fi
}

# Find the STA interface on the specified radio
find_sta_iface() {
	local cfg="$1"
	local mode device disabled
	config_get mode "$cfg" mode
	config_get device "$cfg" device
	config_get disabled "$cfg" disabled "0"
	if [ "$mode" = "sta" ] && [ "$device" = "$radio" ] && [ "$disabled" != "1" ]; then
		sta_cfg_id="$cfg"
	fi
}

# Find AP interfaces on the specified radio
find_ap_ifaces() {
	local cfg="$1"
	local mode device disabled
	config_get mode "$cfg" mode
	config_get device "$cfg" device
	config_get disabled "$cfg" disabled "0"
	if [ "$mode" = "ap" ] && [ "$device" = "$radio" ] && [ "$disabled" != "1" ]; then
		ap_cfg_ids="$ap_cfg_ids $cfg"
	fi
}

# Get dynamic OS interface name (e.g. wlan0-1) for a UCI wireless section using ubus
get_ifname() {
	local radio="$1"
	local section="$2"
	ubus call network.wireless status | jsonfilter -e "@['$radio'].interfaces[@.section='$section'].ifname" 2>/dev/null
}

# Check if a wireless interface is up according to netifd
is_iface_up() {
	local radio="$1"
	local section="$2"
	local state=$(ubus call network.wireless status | jsonfilter -e "@['$radio'].interfaces[@.section='$section'].up" 2>/dev/null)
	[ "$state" = "true" ]
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
	scan_disable_ap=$(uci -q get wifi-monitor.config.scan_disable_ap || echo "0")

	config_load wireless
	sta_cfg_id=""
	ap_cfg_ids=""
	config_foreach find_sta_iface wifi-iface
	config_foreach find_ap_ifaces wifi-iface

	if [ -z "$sta_cfg_id" ]; then
		log 1 "No active STA interface configured on $radio. Sleeping..."
		sleep "$interval"
		continue
	fi

	# Dynamically discover the active OS interface name for the STA config
	sta_ifname=$(get_ifname "$radio" "$sta_cfg_id")

	if [ -z "$sta_ifname" ]; then
		log 2 "STA interface is not created yet. Waiting for wireless stack..."
		sleep "$interval"
		continue
	fi

	# 1. Check link status of STA
	ap_mac=$(iwinfo "$sta_ifname" info 2>/dev/null | grep "Access Point:" | awk '{print $3}')
	is_connected=0
	if [ -n "$ap_mac" ] && [ "$ap_mac" != "00:00:00:00:00:00" ] && [ "$ap_mac" != "Not-Associated" ]; then
		is_connected=1
	fi

	if [ "$is_connected" -eq 1 ]; then
		# SCENARIO B: STA is connected. Verify channel alignment and AP health.
		actual_chan=$(iwinfo "$sta_ifname" info 2>/dev/null | grep -i "Channel:" | sed -n 's/.*Channel: \([0-9]*\).*/\1/p')
		configured_chan=$(uci -q get wireless."$radio".channel || echo "auto")

		# Check if local AP interfaces are up
		ap_down=0
		for ap_cfg in $ap_cfg_ids; do
			if ! is_iface_up "$radio" "$ap_cfg"; then
				ap_down=1
				log 1 "Local AP interface ($ap_cfg) is down according to netifd!"
				break
			fi
		done

		if [ -n "$actual_chan" ] && { [ "$configured_chan" != "$actual_chan" ] || [ "$ap_down" -eq 1 ]; }; then
			log 1 "Channel drift detected or AP is down! STA running channel: $actual_chan, UCI configured: $configured_chan."
			log 1 "Syncing UCI radio channel and restarting wifi stack..."
			uci set wireless."$radio".channel="$actual_chan"
			uci commit wireless
			wifi reload
		else
			log 2 "STA is connected on channel $actual_chan. AP state is healthy."
		fi
	else
		# SCENARIO A: STA is disconnected. Perform scan and align channel.
		log 1 "STA interface $sta_ifname is disconnected. Recovering channel sync..."

		# Get configured SSID & BSSID
		config_get ssid "$sta_cfg_id" ssid
		config_get bssid "$sta_cfg_id" bssid

		# 1. Temporarily disable local AP interfaces if troubleshooting option is set
		if [ "$scan_disable_ap" -eq 1 ] && [ -n "$ap_cfg_ids" ]; then
			log 1 "Temporarily disabling local AP interfaces to clear radio channel for scanning..."
			for ap_cfg in $ap_cfg_ids; do
				uci set wireless."$ap_cfg".disabled='1'
			done
			uci commit wireless
			wifi reload
			sleep 5
			# Re-discover active interface name after reload
			sta_ifname=$(get_ifname "$radio" "$sta_cfg_id")
		fi

		# 2. Perform scan to find the upstream channel
		scan_results=""
		if [ -n "$sta_ifname" ]; then
			log 2 "Scanning for upstream AP (SSID: $ssid, BSSID: $bssid) on $sta_ifname..."
			scan_results=$(iwinfo "$sta_ifname" scan 2>/dev/null)
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

		# 3. Restore disabled AP interfaces in UCI configuration if they were disabled
		if [ "$scan_disable_ap" -eq 1 ] && [ -n "$ap_cfg_ids" ]; then
			log 1 "Restoring local AP interfaces in configuration..."
			for ap_cfg in $ap_cfg_ids; do
				uci set wireless."$ap_cfg".disabled='0'
			done
			uci commit wireless
		fi

		if [ -n "$target_chan" ]; then
			cur_chan=$(uci -q get wireless."$radio".channel || echo "auto")
			if [ "$cur_chan" != "$target_chan" ] || [ "$scan_disable_ap" -eq 1 ]; then
				log 1 "Upstream AP found on channel $target_chan (currently configured: $cur_chan). Syncing radio channel..."
				uci set wireless."$radio".channel="$target_chan"
				uci commit wireless
				wifi reload
			else
				log 2 "Upstream AP is on the same channel ($cur_chan). Allowing wpa_supplicant to reconnect..."
			fi
		else
			log 1 "Upstream AP ($ssid / $bssid) not found in scan results. Sleeping."
			if [ "$scan_disable_ap" -eq 1 ]; then
				log 1 "Reloading wireless stack to bring back disabled AP interfaces..."
				wifi reload
			fi
		fi
	fi

	sleep "$interval"
done
