#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Clone custom LuCI app packages into the build tree
mkdir -p package/luci-app-nat66
cp -r $GITHUB_WORKSPACE/package/luci-app-nat66/* package/luci-app-nat66/

git clone --depth=1 https://github.com/miao1007/openwrt-dogcom package/openwrt-dogcom
git clone --depth=1 https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome
git clone --depth=1 https://github.com/sirpdboy/netspeedtest package/luci-app-netspeedtest
