#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# Modify default theme
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
sed -i 's/OpenWrt/LEDE/g' package/base-files/files/bin/config_generate

# Custom NTP servers: replace stock openwrt.pool.ntp.org with Ali/Tencent/NTSC/Apple
sed -i "s/0.openwrt.pool.ntp.org/ntp1.aliyun.com/g" package/base-files/files/bin/config_generate
sed -i "s/1.openwrt.pool.ntp.org/ntp.tencent.com/g" package/base-files/files/bin/config_generate
sed -i "s/2.openwrt.pool.ntp.org/ntp.ntsc.ac.cn/g" package/base-files/files/bin/config_generate
sed -i "s/3.openwrt.pool.ntp.org/time.apple.com/g" package/base-files/files/bin/config_generate

# Default LED behaviour (via uci-defaults, runs on first boot)
mkdir -p files/etc/uci-defaults
cat > files/etc/uci-defaults/99-led-config << 'EOF'
#!/bin/sh
uci -q delete system.led_power
uci -q delete system.led_status
uci add system led
uci set system.@led[-1].name='red:power'
uci set system.@led[-1].sysfs='red:power'
uci set system.@led[-1].default='1'
uci set system.@led[-1].trigger='default-on'
uci add system led
uci set system.@led[-1].name='white:status'
uci set system.@led[-1].sysfs='white:status'
uci set system.@led[-1].trigger='netdev'
uci set system.@led[-1].dev='br-lan'
uci set system.@led[-1].mode='link tx rx'
uci commit system
EOF
chmod +x files/etc/uci-defaults/99-led-config

# Fix Rust compilation: disable download-ci-llvm
sed -i 's/$(TARGET_CONFIGURE_ARGS)/--set llvm.download-ci-llvm=false \\\n\t$(TARGET_CONFIGURE_ARGS)/' feeds/packages/lang/rust/Makefile
