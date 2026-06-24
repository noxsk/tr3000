#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# Modify default theme
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify default NTP servers
python3 -c "
with open('package/base-files/files/etc/config/system', 'r') as f:
    lines = f.readlines()
new_lines = []
for line in lines:
    if 'list server' in line:
        continue
    new_lines.append(line)
    if 'config timeserver' in line:
        new_lines.append(\"\tlist server 'ntp1.aliyun.com'\n\")
        new_lines.append(\"\tlist server 'ntp.tencent.com'\n\")
        new_lines.append(\"\tlist server 'ntp.ntsc.ac.cn'\n\")
        new_lines.append(\"\tlist server 'time.apple.com'\n\")
with open('package/base-files/files/etc/config/system', 'w') as f:
    f.writelines(new_lines)
"

# Configure default LEDs
python3 -c "
with open('package/base-files/files/etc/config/system', 'a') as f:
    f.write('''
config led 'power_led'
	option name 'Power LED'
	option sysfs 'red:power'
	option trigger 'default-on'

config led 'status_led'
	option name 'Status LED'
	option sysfs 'white:status'
	option trigger 'netdev'
	option dev 'br-lan'
	option mode 'link tx rx'
''')
"

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# 修复 Rust 编译失败：强制关闭 download-ci-llvm
sed -i 's/$(TARGET_CONFIGURE_ARGS)/--set llvm.download-ci-llvm=false \\\n\t$(TARGET_CONFIGURE_ARGS)/' feeds/packages/lang/rust/Makefile

# 启用 ccache 编译缓存以加速后续编译
echo "CONFIG_CCACHE=y" >> .config
