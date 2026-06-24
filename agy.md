# 🤖 Antigravity AI Logs & Changelog

This document is used to record the interaction logs with the AI assistant (Antigravity), project modifications, and the repository's changelog.

---

## 📅 AI Session Logs (AI 交互记录)

Here is the log of tasks completed by AI assistants in this workspace.

| 日期 (Date) | 任务目标 (Goal) | 关联文件 (Related Files) | 状态 (Status) | 备注 (Notes) |
| :--- | :--- | :--- | :--- | :--- |
| 2026-06-25 | 恢复 GitHub Actions 工作流文件 | [.github/workflows/openwrt-builder.yml](file:///Users/noxsk/Git/tr3000/.github/workflows/openwrt-builder.yml), [.github/workflows/update-checker.yml](file:///Users/noxsk/Git/tr3000/.github/workflows/update-checker.yml) | ✅ Completed | 从 P3TERX Actions-OpenWrt 模板恢复了 openwrt-builder.yml 和 update-checker.yml 并配置了自定义配置文件名。 |
| 2026-06-25 | 启用 watchcat 断网重启插件 | [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) | ✅ Completed | 启用了 `luci-app-watchcat` 网页端及其底层的断网检测重启守护程序 `watchcat`。 |
| 2026-06-25 | 启用 mwan3helper 分流助手 | [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) | ✅ Completed | 启用了 `luci-app-mwan3helper-chinaroute` 插件。 |
| 2026-06-25 | 内置 curl, wget, sudo, bash | [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) | ✅ Completed | 在编译配置中内置 curl、wget-ssl、sudo 和 bash 命令行工具。 |
| 2026-06-25 | 编写并添加自定义 NAT66 快速配置插件 | [package/luci-app-nat66/](file:///Users/noxsk/Git/tr3000/package/luci-app-nat66/), [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) | ✅ Completed | 编写了 `luci-app-nat66` 插件，解决不同设备在 NAT66 下路由宣告 (ra_default) 缺失及防火墙配置繁琐的问题，并在 `.config` 中启用。 |
| 2026-06-25 | 启用 USB 网络共享及手机绑定驱动 | [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) | ✅ Completed | 启用了 `kmod-usb-net` 及其子网卡驱动（RNDIS、CDC-Ether、iPhone ipheth）。 |
| 2026-06-25 | 添加 dogcom 校园网认证插件 | [diy-part1.sh](file:///Users/noxsk/Git/tr3000/diy-part1.sh), [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) | ✅ Completed | 在 `diy-part1.sh` 中克隆 `openwrt-dogcom` 仓库，并在 `.config` 中启用拨号程序及网页端插件。 |
| 2026-06-25 | 内置 Adguard Home 广告拦截插件 | [diy-part1.sh](file:///Users/noxsk/Git/tr3000/diy-part1.sh), [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) | ✅ Completed | 在 `diy-part1.sh` 中克隆 `luci-app-adguardhome` 插件仓库，并在 `.config` 中启用。 |
| 2026-06-25 | 启用并配置 LED 扩展触发器插件与默认行为 | [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config), [diy-part2.sh](file:///Users/noxsk/Git/tr3000/diy-part2.sh) | ✅ Completed | 启用 RSSI、Switch、USBPort LED 网页触发器插件，并在 `diy-part2.sh` 中配置默认电源红灯与状态白灯行为。 |
| 2026-06-25 | 定制默认 NTP 时间同步服务器 | [diy-part2.sh](file:///Users/noxsk/Git/tr3000/diy-part2.sh) | ✅ Completed | 在 `diy-part2.sh` 中增加 Python 脚本替换默认 NTP 服务器为阿里、腾讯、国家授时中心及苹果。 |
| 2026-06-25 | 启用 UPnP IGD/PCP/NAT-PMP 服务 | [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) | ✅ Completed | 启用了 `luci-app-upnp`、`miniupnpd-nftables` 及其配套中文翻译包 `luci-i18n-upnp-zh-cn`。 |
| 2026-06-25 | 启用 mwan3 多线多拨负载均衡插件 | [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) | ✅ Completed | 启用了 `mwan3`、`luci-app-mwan3` 及其配套中文翻译包 `luci-i18n-mwan3-zh-cn`。 |
| 2026-06-25 | 添加 netspeedtest 内网测试插件 | [diy-part1.sh](file:///Users/noxsk/Git/tr3000/diy-part1.sh), [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) | ✅ Completed | 在 `diy-part1.sh` 中拉取 `netspeedtest` 仓库，并在 `.config` 中启用该插件。 |
| 2026-06-25 | 启用并设置 Argon 为默认主题 | [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config), [diy-part2.sh](file:///Users/noxsk/Git/tr3000/diy-part2.sh) | ✅ Completed | 启用 `luci-theme-argon`，禁用 `luci-theme-bootstrap`，并在 `diy-part2.sh` 中配置其为默认主题。 |
| 2026-06-25 | 修改默认 LAN IP 为 192.168.2.1 | [diy-part2.sh](file:///Users/noxsk/Git/tr3000/diy-part2.sh) | ✅ Completed | 在 `diy-part2.sh` 中启用默认 IP 替换，设置为 `192.168.2.1`。 |
| 2026-06-25 | 启用 Netdata 性能监控面板及其中文包 | [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) | ✅ Completed | 启用了 `luci-app-netdata` 及其配套中文翻译包 `luci-i18n-netdata-zh-cn`。 |
| 2026-06-25 | 彻底移除 PassWall 相关配置组件 | [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) | ✅ Completed | 移除了 `.config` 中所有残留的 PassWall 子组件及选项。 |
| 2026-06-24 | 移除 256MB 固件配置，仅保留 128MB (MOD) 版本 | [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) | ✅ Completed | 删除了 `TR3000V1_256M.config`，仅保留 `TR3000V1_MOD.config` 作为 128MB (MOD) 版本配置。 |
| 2026-06-24 | 初始化 `agy.md` AI 日志记录文件 | [agy.md](file:///Users/noxsk/Git/tr3000/agy.md) | ✅ Completed | 创建此文件以规范化后续 AI 开发流程与更新记录。 |

<details>
<summary>🔍 <b>展开/折叠详细日志记录 (Detailed Session Details)</b></summary>

### 📝 Session: 2026-06-25 (恢复 Actions 工作流)
* **目标**: 恢复并适配 GitHub Actions 自动化云编译所需的工作流文件。
* **修改内容**:
  * 恢复并修改 [.github/workflows/openwrt-builder.yml](file:///Users/noxsk/Git/tr3000/.github/workflows/openwrt-builder.yml)：
    * 将环境变量中的 `CONFIG_FILE` 修改为 `TR3000V1_MOD.config`，以自动适配项目当前的 128MB Mod 配置文件。
    * 清理了模板中未声明的环境变量 `UPLOAD_GOFILE` 可能导致的语法异常。
  * 恢复 [.github/workflows/update-checker.yml](file:///Users/noxsk/Git/tr3000/.github/workflows/update-checker.yml) 源码更新检测触发器工作流。
* **成果**: 本地仓库重新集成 GitHub Actions CI 脚本，支持在推送到 GitHub 后一键启动自动化编译。

### 📝 Session: 2026-06-25 (添加 watchcat 插件)
* **目标**: 启用断网自动重启/连接守护插件 `watchcat` 及其 LuCI 界面。
* **修改内容**:
  * 修改 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config)：
    * 启用 `CONFIG_PACKAGE_watchcat=y` (断网检测重启守护服务)。
    * 启用 `CONFIG_PACKAGE_luci-app-watchcat=y` (LuCI 网页控制后台)。
* **成果**: 固件编译后将包含 watchcat 面板，支持在网络断开时自动执行指定网口重启或路由器整机重启以恢复网络。

### 📝 Session: 2026-06-25 (添加 mwan3helper 插件)
* **目标**: 启用 MWAN3 分流助手插件 `luci-app-mwan3helper-chinaroute`，以辅助配置国内 IP 段分流。
* **修改内容**:
  * 修改 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config)：
    * 启用 `CONFIG_PACKAGE_luci-app-mwan3helper-chinaroute=y`。
* **成果**: 固件编译后将包含 MWAN3 分流助手，方便设置国内流量与海外流量的策略分流。

### 📝 Session: 2026-06-25 (内置 curl wget sudo bash)
* **目标**: 在固件中内置常用的命令行工具 `curl`、`wget` (以 `wget-ssl` 实现)、`sudo` 和 `bash`。
* **修改内容**:
  * 修改 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config)：
    * 启用 `CONFIG_PACKAGE_curl=y`。
    * 启用 `CONFIG_PACKAGE_wget-ssl=y`。
    * 启用 `CONFIG_PACKAGE_sudo=y`。
    * 启用 `CONFIG_PACKAGE_bash=y`。
* **成果**: 固件编译后将直接内置上述常用命令行工具，方便终端调试和运行脚本。

### 📝 Session: 2026-06-25 (编写并添加 NAT66 快速配置插件)
* **目标**: 针对非苹果设备在 NAT66 模式下因路由通告 (RA) 导致无法使用 IPv6 的系统级差异问题，编写一个一键开启 NAT66 模式的 LuCI 网页端插件。
* **修改内容**:
  * 编写 [luci-app-nat66](file:///Users/noxsk/Git/tr3000/package/luci-app-nat66/)：
    * `Makefile`：定义 OpenWrt 编译包结构。
    * `etc/config/nat66`：定义默认配置项（开启状态、WAN 口）。
    * `etc/init.d/nat66`：服务初始化脚本。开启时自动设置 `ra_default='1'`、`ra_management='1'` 以强制下发默认网关路由并重启 `odhcpd`；自动检测并处理 Firewall4 (nftables 选项 `masquerade_v6`) 与 Firewall3 (iptables 规则 `MASQUERADE`) 的 IPv6 伪装。
    * `controller/nat66.lua` & `model/cbi/nat66.lua`：编写 LuCI 网页后台控制面板与切换开关。
  * 修改 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config)：在文件尾部启用编译 `CONFIG_PACKAGE_luci-app-nat66=y`。
* **成果**: 固件编译后将包含独立的 NAT66 网页控制插件，可一键完成 IPv6 伪装以及所有设备（包括 Windows/Linux/Android）默认路由通告 of 快速配置，彻底解决兼容性问题。

### 📝 Session: 2026-06-25 (添加 USB 共享驱动)
* **目标**: 启用 USB 共享网络/USB 手机热点绑定驱动，以实现连接安卓/苹果手机或随身 Wi-Fi 网卡上网。
* **修改内容**:
  * 修改 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config)：
    * 启用核心 USB 网络共享：`CONFIG_PACKAGE_kmod-usb-net=y`。
    * 启用安卓/Windows (RNDIS) 网卡驱动：`CONFIG_PACKAGE_kmod-usb-net-rndis=y`。
    * 启用以太网标准 (CDC-ECM) 网卡驱动：`CONFIG_PACKAGE_kmod-usb-net-cdc-ether=y`。
    * 启用苹果 iPhone (IPHETH) 共享驱动：`CONFIG_PACKAGE_kmod-usb-net-ipheth=y`。
* **成果**: 固件编译后将完整支持通过 USB 插手机/随身网卡共享蜂窝移动网络上网。

### 📝 Session: 2026-06-25 (添加 dogcom 认证)
* **目标**: 增加 Dr.com 校园网拨号认证客户端 `dogcom` 及其网页管理界面。
* **修改内容**:
  * 修改 [diy-part1.sh](file:///Users/noxsk/Git/tr3000/diy-part1.sh)：追加克隆命令 `git clone --depth=1 https://github.com/miao1007/openwrt-dogcom package/openwrt-dogcom`。
  * 修改 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config)：在文件尾部启用编译 `CONFIG_PACKAGE_dogcom=y` 和 `CONFIG_PACKAGE_luci-app-dogcom=y`。
* **成果**: 固件编译后将包含 Dr.com 校园网后台自动拨号认证功能。

### 📝 Session: 2026-06-25 (添加 Adguard Home)
* **目标**: 内置 Adguard Home 广告拦截与隐私保护服务及网页管理面板。
* **修改内容**:
  * 修改 [diy-part1.sh](file:///Users/noxsk/Git/tr3000/diy-part1.sh)：追加命令 `git clone --depth=1 https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome`。
  * 修改 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config)：
    * 启用核心守护程序：`CONFIG_PACKAGE_adguardhome=y`。
    * 启用网页控制界面：`CONFIG_PACKAGE_luci-app-adguardhome=y`。
* **成果**: 固件编译后将包含 Adguard Home 去广告和 DNS 防污染管理功能。

### 📝 Session: 2026-06-25 (配置 LED 灯行为)
* **目标**: 启用额外的 LED 触发器控制插件，并对 Cudy TR3000 V1 硬件上的 LED 灯自定义默认起亮/闪烁行为。
* **修改内容**:
  * 修改 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config)：
    * 启用 `CONFIG_PACKAGE_luci-app-ledtrig-rssi=y` (信号强度触发器插件)。
    * 启用 `CONFIG_PACKAGE_luci-app-ledtrig-switch=y` (交换机网口触发器插件)。
    * 启用 `CONFIG_PACKAGE_luci-app-ledtrig-usbport=y` (USB 挂载触发器插件)。
  * 修改 [diy-part2.sh](file:///Users/noxsk/Git/tr3000/diy-part2.sh)：使用 Python 脚本在固件的 `/etc/config/system` 追加默认 of LED 硬件灯定义：
    * `red:power` 灯设置为 `default-on` (常亮)。
    * `white:status` 灯设置为 `netdev` 触发，监控 `br-lan` 网卡的网络收发流量。
* **成果**: 固件首次开机时可确保正确的 LED 指示，且网页中拥有更丰富的触发器选项。

### 📝 Session: 2026-06-25 (定制 NTP 服务器)
* **目标**: 将编译出的固件默认 NTP 服务器修改为指定的优质服务器列表。
* **修改内容**:
  * 修改 [diy-part2.sh](file:///Users/noxsk/Git/tr3000/diy-part2.sh)：插入一段 Python 脚本，以修改固件中的 `/etc/config/system` 文件，将时间服务器列表替换为：
    * `ntp1.aliyun.com`
    * `ntp.tencent.com`
    * `ntp.ntsc.ac.cn`
    * `time.apple.com`
* **成果**: 固件首次开机时将自动连接这些 NTP 服务器进行快速时间同步。

### 📝 Session: 2026-06-25 (添加 UPnP 支持)
* **目标**: 启用 UPnP IGD 和 PCP/NAT-PMP 服务以支持局域网设备自动进行端口映射。
* **修改内容**:
  * 修改 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config)：
    * 启用 `CONFIG_PACKAGE_luci-app-upnp=y`。
    * 启用 `CONFIG_PACKAGE_luci-i18n-upnp-zh-cn=y`。
    * 启用对应 nftables 防火墙的 daemon：`CONFIG_PACKAGE_miniupnpd-nftables=y`。
* **成果**: 固件编译后将包含 UPnP/NAT-PMP 自动端口映射服务。

### 📝 Session: 2026-06-25 (添加 mwan3)
* **目标**: 启用多线多拨和负载均衡插件 `mwan3` 及其网页配置页面和中文语言包。
* **修改内容**:
  * 修改 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config)：
    * 启用 `CONFIG_PACKAGE_mwan3=y`。
    * 启用 `CONFIG_PACKAGE_luci-app-mwan3=y`。
    * 启用 `CONFIG_PACKAGE_luci-i18n-mwan3-zh-cn=y`。
* **成果**: 固件编译后将支持多 WAN 口多拨及负载均衡配置。

### 📝 Session: 2026-06-25 (添加 netspeedtest 插件)
* **目标**: 增加内网测速插件 `luci-app-netspeedtest`。
* **修改内容**:
  * 修改 [diy-part1.sh](file:///Users/noxsk/Git/tr3000/diy-part1.sh)：添加 `git clone --depth=1 https://github.com/sirpdboy/netspeedtest package/luci-app-netspeedtest`。
  * 修改 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config)：在文件尾部启用插件编译 `CONFIG_PACKAGE_luci-app-netspeedtest=y`。
* **成果**: 固件编译后将包含内网网络速度测试页面。

### 📝 Session: 2026-06-25 (启用 Argon 主题)
* **目标**: 启用 `luci-theme-argon` 并将其设为默认主题。
* **修改内容**:
  * 修改 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config)：启用 `luci-theme-argon=y`，禁用 `luci-theme-bootstrap`。
  * 修改 [diy-part2.sh](file:///Users/noxsk/Git/tr3000/diy-part2.sh)：取消注释 `sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile`。
* **成果**: 编译出来的固件默认后台管理页面应用美观的 Argon 主题。

### 📝 Session: 2026-06-25 (修改默认 IP)
* **目标**: 将路由器的默认局域网 (LAN) IP 地址从 `192.168.1.1` 改为 `192.168.2.1`。
* **修改内容**:
  * 修改 [diy-part2.sh](file:///Users/noxsk/Git/tr3000/diy-part2.sh)：取消注释并修改第 14 行的 sed 替换命令为 `sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate`。
* **成果**: 编译出来的固件默认网关和后台管理 IP 将变更为 `192.168.2.1`。

### 📝 Session: 2026-06-25 (添加 Netdata 监控)
* **目标**: 启用 Netdata 性能/资源实时监控面板及其中文语言包。
* **修改内容**:
  * 修改 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config)：
    * 启用核心守护程序：`CONFIG_PACKAGE_netdata=y`。
    * 启用 Web 界面插件：`CONFIG_PACKAGE_luci-app-netdata=y`。
    * 启用中文翻译包：`CONFIG_PACKAGE_luci-i18n-netdata-zh-cn=y`。
* **成果**: 固件编译后将包含功能强大的实时系统资源性能图表界面。

### 📝 Session: 2026-06-25
* **目标**: 彻底从固件编译配置中移除 PassWall 插件及其依赖。
* **修改内容**:
  * 修改 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config)，将原本默认开启的 `CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_Rust_Server=y`、`CONFIG_PACKAGE_luci-app-passwall_INCLUDE_SingBox=y`、`CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray_Geoview=y` 全部设为 `is not set`（不启用）。
* **成果**: 清理了所有的科学上网残留组件，固件更加纯净。

### 📝 Session: 2026-06-24 (移除 256MB 版本)
* **目标**: 移除 256MB 固件版本，只提供 128MB 版本配置。
* **修改内容**:
  * 删除 `TR3000V1_256M.config` 配置文件。
  * 保留 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) 不作更名，作为 128MB Uboot-Mod 硬件版本的固件配置。
* **成果**: 精简了项目配置，明确了只支持 128MB Uboot-Mod 硬件的目标。

### 📝 Session: 2026-06-24
* **目标**: 为项目创建 AI 协作日志文件 `agy.md`。
* **修改内容**:
  * 新建 [agy.md](file:///Users/noxsk/Git/tr3000/agy.md) 文件，定义了日志模版、更新日志区块和日志书写规范。
* **成果**: 建立了一个结构清晰、美观的 AI 日志记录规范，有助于追踪 AI 在 OpenWrt 固件定制开发过程中的各项修改。

</details>

---

## 🚀 Project Changelog (项目更新日志)

All firmware configurations, custom scripts, and workflow modifications are documented here.

### [Unreleased]

#### Added
- 恢复了 GitHub Actions 云端编译工作流 [.github/workflows/openwrt-builder.yml](file:///Users/noxsk/Git/tr3000/.github/workflows/openwrt-builder.yml) 和源码更新检查器 [.github/workflows/update-checker.yml](file:///Users/noxsk/Git/tr3000/.github/workflows/update-checker.yml)。
- 启用了断网检测重启插件 `luci-app-watchcat` 和 `watchcat`（在 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) 中启用）。
- 启用了 MWAN3 分流助手插件 `luci-app-mwan3helper-chinaroute`（在 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) 中启用）。
- 内置了常用命令行工具 `curl`、`wget-ssl` (wget)、`sudo` 和 `bash`（在 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) 中启用）。
- 新增了自定义的 NAT66 快速配置应用 `luci-app-nat66`（在 [package/luci-app-nat66/](file:///Users/noxsk/Git/tr3000/package/luci-app-nat66/) 中编写，并在 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) 中启用编译）。
- 启用了 USB 共享网络所需的完整驱动程序链（包括基础模块 `kmod-usb-net`、Android 共享 `kmod-usb-net-rndis`、标准 `kmod-usb-net-cdc-ether` 以及 iPhone 专用的 `kmod-usb-net-ipheth`）。
- 新增了 Dr.com 校园网认证工具 dogcom (`luci-app-dogcom` 和 `dogcom`；通过 [diy-part1.sh](file:///Users/noxsk/Git/tr3000/diy-part1.sh) 克隆，并在 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) 中启用）。
- 新增了广告拦截和 DNS 过滤管理工具 AdGuard Home (`luci-app-adguardhome` 和 `adguardhome`；通过 [diy-part1.sh](file:///Users/noxsk/Git/tr3000/diy-part1.sh) 克隆，并在 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) 中启用）。
- 启用了额外的 LED 控制触发器网页插件 (`luci-app-ledtrig-rssi`, `luci-app-ledtrig-switch`, `luci-app-ledtrig-usbport`)。
- 启用了 UPnP IGD 和 PCP/NAT-PMP 自动端口映射服务 (`luci-app-upnp` 和 `miniupnpd-nftables`) 及其配套的中文语言包 (`luci-i18n-upnp-zh-cn`)。
- 启用了多线多拨负载均衡工具 mwan3 (`luci-app-mwan3`) 及其配套的中文语言包 (`luci-i18n-mwan3-zh-cn`)。
- 新增了内网测速插件 `luci-app-netspeedtest`（通过 [diy-part1.sh](file:///Users/noxsk/Git/tr3000/diy-part1.sh) 克隆，并在 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) 中启用）。
- 启用了实时系统资源性能监控工具 Netdata (`luci-app-netdata`) 及其配套的中文语言包 (`luci-i18n-netdata-zh-cn`)。
- 新增 AI 协作日志记录文件 [agy.md](file:///Users/noxsk/Git/tr3000/agy.md)。

#### Changed
- 自定义了设备 LED 的默认启动行为（电源红灯常亮，状态白灯在局域网有网络数据时闪烁；在 [diy-part2.sh](file:///Users/noxsk/Git/tr3000/diy-part2.sh) 中以 Python 脚本处理）。
- 将默认 NTP 时间同步服务器修改为国内及苹果的 NTP 组（在 [diy-part2.sh](file:///Users/noxsk/Git/tr3000/diy-part2.sh) 中以 Python 脚本处理）。
- 将默认网页后台主题由 Bootstrap 更换为 Argon (`luci-theme-argon`)（在 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) 和 [diy-part2.sh](file:///Users/noxsk/Git/tr3000/diy-part2.sh) 中配置）。
- 将固件的默认局域网 (LAN) 网关 IP 变更为 `192.168.2.1`（在 [diy-part2.sh](file:///Users/noxsk/Git/tr3000/diy-part2.sh) 中通过 sed 命令进行默认值修改）。

#### Removed
- 彻底从编译配置中移除了 PassWall 科学上网插件及其所有残留的子依赖（如 Shadowsocks-Rust 服务端、SingBox、V2ray Geoview 选项）。
- 删除了 256MB RAM 版本的编译配置文件 `TR3000V1_256M.config`。

#### Fixed
- *暂无*

---

## 🧠 Core Insights & Context (核心上下文与决策要点)

为了减少后续 AI 会话的重复思考和调研，请牢记以下关键要点：

1. **目标硬件平台**：
   - 目标设备为 Cudy TR3000 V1（基于 MediaTek MT7981 / filogic 架构）。
   - 该设备在 OpenWrt 社区存在多种硬件规格与分区布局。本项目目前已移除 256MB 版本，**仅提供 128MB (Uboot-Mod) 版本**。
   - 对应的编译配置文件为 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config)。
2. **OpenWrt 配置文件中关于 TR3000 V1 相关的 Profile 区别**：
   - `cudy_tr3000-v1`：原厂分区布局。
   - `cudy_tr3000-v1-ubootmod`：第三方 Uboot-Mod 分区布局（通常扩容了软件分区，在 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) 中被启用，即 `CONFIG_TARGET_mediatek_filogic_DEVICE_cudy_tr3000-v1-ubootmod=y`）。
   - `cudy_tr3000-v1-256mb`：专为 256MB RAM 硬件定制的布局（已被彻底移除）。
3. **DIY 脚本关键修正**：
   - [diy-part2.sh](file:///Users/noxsk/Git/tr3000/diy-part2.sh) 中包含针对 OpenWrt 编译 Rust 相关包失败的强制修复补丁（通过在 Makefile 中关闭 `download-ci-llvm`）。

---

## 🛠️ Logging Guidelines (日志更新规范)

为保持此文件的整洁与一致性，请在与 AI 交互或更新项目时遵循以下记录规范：

### 1. 格式要求
* **时间格式**：使用 `YYYY-MM-DD` 格式。
* **文件链接**：对于引用的本地文件，使用 Markdown 绝对路径链接，例如 `[README.md](file:///Users/noxsk/Git/tr3000/README.md)`。
* **标签规范**：
  * `✅ Completed` - 任务已完成且测试通过
  * `⏳ In Progress` - 任务进行中
  * `⚠️ Paused/Blocked` - 任务受阻或挂起

### 2. 更新步骤
1. **更新表格**：在 `📅 AI Session Logs` 表格顶部插入最新一行的交互记录。
2. **补充详细日志**：在 `<details>` 标签内的顶部添加详细修改描述。
3. **维护更新日志**：在 `🚀 Project Changelog` 下的合适版本分类中记录具体的代码变更（例如 Added, Changed, Fixed）。
