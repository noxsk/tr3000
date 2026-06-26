#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# Clone custom packages
git clone --depth=1 https://github.com/sirpdboy/netspeedtest package/luci-app-netspeedtest
git clone --depth=1 https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome
git clone --depth=1 https://github.com/mchome/openwrt-dogcom package/openwrt-dogcom

# 复制本仓库自带的自定义插件到 OpenWrt 编译目录
if [ -d "$GITHUB_WORKSPACE/package" ]; then
	cp -r "$GITHUB_WORKSPACE/package"/* package/
fi

