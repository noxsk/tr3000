# 🤖 Antigravity AI Logs & Changelog

This document is used to record the interaction logs with the AI assistant (Antigravity), project modifications, and the repository's changelog.

---

## 📅 AI Session Logs (AI 交互记录)

Here is the log of tasks completed by AI assistants in this workspace.

| 日期 (Date) | 任务目标 (Goal) | 关联文件 (Related Files) | 状态 (Status) | 备注 (Notes) |
| :--- | :--- | :--- | :--- | :--- |
| 2026-06-28 | 修复 luci-app-nat66/wifi-monitor po2lmo 编译错误 | [package/luci-app-nat66/Makefile](file:///Users/noxsk/Git/tr3000/package/luci-app-nat66/Makefile), [package/luci-app-wifi-monitor/Makefile](file:///Users/noxsk/Git/tr3000/package/luci-app-wifi-monitor/Makefile) | ✅ Completed | 移除无效 PKG_BUILD_DEPENDS, po2lmo 从 Build/Compile 移到 Package/install 直接用命令(不走硬路径)。 |
| 2026-06-28 | 加固 wifi-monitor/nat66 插件鲁棒性 | [wifi-monitor.sh](file:///Users/noxsk/Git/tr3000/package/luci-app-wifi-monitor/root/usr/bin/wifi-monitor.sh), [nat66 init](file:///Users/noxsk/Git/tr3000/package/luci-app-nat66/root/etc/init.d/nat66), [wifi-monitor init](file:///Users/noxsk/Git/tr3000/package/luci-app-wifi-monitor/root/etc/init.d/wifi-monitor), [wifi-monitor.js](file:///Users/noxsk/Git/tr3000/package/luci-app-wifi-monitor/root/www/luci-static/resources/view/wifi-monitor.js) | ✅ Completed | 14项修复: ash 兼容性/local 关键字、interval 边界防死循环、EXIT trap 防 AP 永久禁用、ubus 缓存 O(N)->O(1)、信道同步减冗余 commit、sleep 信号安全、nat66 幂等/ULA 回退/firewall.user 查重/eth1 探针/stop 守卫、procd crash 限制、状态指示去按钮化。 |
| 2026-06-28 | 重写 wifi-monitor.sh 修复多 STA 冲突、信道循环 reload | [package/luci-app-wifi-monitor/root/usr/bin/wifi-monitor.sh](file:///Users/noxsk/Git/tr3000/package/luci-app-wifi-monitor/root/usr/bin/wifi-monitor.sh) | ✅ Completed | 新增 safe_reload 冷却、多 STA 警告、AP 健康时静默同步信道不 reload、追踪全部 STA。 |
| 2026-06-28 | wifi-monitor 新增 sta 选项指定监控特定 STA | [package/luci-app-wifi-monitor/](file:///Users/noxsk/Git/tr3000/package/luci-app-wifi-monitor/) (config/sh/JS/PO) | ✅ Completed | 配置/LuCI 新增 sta 下拉菜单, 指定后只监控该 STA, 其他 STA(如 mwan3 聚合)不受影响。 |
| 2026-06-25 | 修改自动编译为每日5点 | [.github/workflows/openwrt-builder.yml](file:///Users/noxsk/Git/tr3000/.github/workflows/openwrt-builder.yml) | ✅ Completed | 在 openwrt-builder.yml 中添加了 cron 定时任务触发器（设定为北京时间每日早5点/UTC时间前一日晚21点）。 |
| 2026-06-25 | 定制 README 说明与仓库声明 | [README.md](file:///Users/noxsk/Git/tr3000/README.md) | ✅ Completed | 在 README.md 中标注为自用仓库，声明源码来自互联网，仅用于存档编译。 |
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

### 📝 Session: 2026-06-28 (加固插件鲁棒性 — commit 618c7f6)

- **目标**: 根据 agy.md 历史记录中暴露的问题, 系统性加固 wifi-monitor 和 nat66 两个自定义插件。
- **涉及文件**: `wifi-monitor.sh`, `nat66 init`, `wifi-monitor init`, `wifi-monitor.js` (4 files, +96/-31)
- **wifi-monitor.sh 六项修复**:
  - 移除循环体内 `local` 关键字 (busybox ash 仅在 function 内有效)。
  - `interval` 增加 [5s, 3600s] 边界检查, 防止用户误设 0 导致死循环。
  - 新增 EXIT trap: `scan_disable_ap` 期间若脚本崩溃/被 kill, 自动恢复 AP 接口 (防止 AP 永久禁用)。
  - 每轮循环缓存 `ubus call network.wireless status` 一次, `get_ifname()`/`is_iface_up()` 复用缓存 (减少 O(N) 次 ubus 调用)。
  - AP 宕机恢复路径增加信道比较, 仅在信道确实变化时才 `uci commit` (减少 SPI NOR 闪存擦写)。
  - 所有 `sleep` 改为 `sleep "$interval" & wait $!` 信号安全模式。
- **nat66 init 五项修复**:
  - `start_service()` 增加幂等性检查 (`ra_default` 已为 1 则直接返回)。
  - ULA 前缀生成增加 `/dev/urandom` 缺失时的确定性回退值 (防 `fd:::/48` 非法前缀)。
  - `firewall.user` 追加前 `grep -qF` 查重, 防止并发 start 产生重复块。
  - `get_wan_device()` 用 `/sys/class/net/` 探针替代硬编码 `eth1`。
  - `stop_service()` 仅在 `ra_default=1` (确实 start 过) 时才执行清理。
- **wifi-monitor init 一项修复**:
  - `procd respawn` 增加 crash 阈值: `respawn 3600 5 10` (1 小时内最多 10 次崩溃)。
- **wifi-monitor.js 一项修复**:
  - 状态指示器去按钮化: 移除 `border-radius`/`padding`/`border`/背景色 pill 形状, 改为纯文本+彩色圆点 (active: 绿色 pulse, inactive: 红色 static)。keyframe 名限定为 `wifimon-pulse` 避免主题冲突。

### 📝 Session: 2026-06-28 (修复 po2lmo 编译错误 — commit 74e30b1)

- **目标**: 修复 CI Run #12/#13 中 `luci-app-nat66` 编译失败 (Error 127: po2lmo not found)。
- **根因**:
  - `PKG_BUILD_DEPENDS:=luci-base/host` 不被构建系统识别 (log: "does not exist"), po2lmo 编译顺序无法保证。
  - `$(STAGING_DIR_HOST)/bin/po2lmo` 路径错误: po2lmo 实际安装于 `$(STAGING_DIR_HOSTPKG)/bin/po2lmo` (即 `staging_dir/hostpkg/bin/`)。
  - Run #11 成功仅因 `-` 前缀静默跳过错误, i18n 实际未生效。
- **修复**:
  - 删除无效 `PKG_BUILD_DEPENDS`。
  - po2lmo 从 `Build/Compile` 移到 `Package/install`，直接用 `po2lmo` 命令（遵循其他 LuCI 包的标准做法, 安装期 PATH 已包含 hostpkg/bin）。
  - 影响文件: `package/luci-app-nat66/Makefile`, `package/luci-app-wifi-monitor/Makefile`。

### 📝 Session: 2026-06-28 (重写 wifi-monitor.sh — commit 2cf00ea)

- **目标**: 修复 wifi-monitor 在多 STA 环境下触发 wpa_supplicant deinit 循环, 导致 WiFi 反复断开。
- **根因分析**:
  - **mt76 驱动 bug**: 同一 radio 上多个 STA 连同一 AP 时, wpa_supplicant `CTRL-EVENT-SUBNET-STATUS-UPDATE` 触发 `nl80211: deinit` 重置整张网卡 → AP 接口也一起被清 → 客户端断开 → 短暂闪现未加密 SSID（即用户看到的 "LEDE 默认开放 WiFi"）。
  - **脚本缺陷**: 只追踪最后一个 STA（其余被覆盖）、STA 连接时仍因 UCI 信道与实信道不一致而 `wifi reload`（共享 radio 下信道由 STA 决定, reload 无效且破坏连接）、无冷却机制。
- **修复**:
  - 追踪所有 STA（`find_sta_ifaces` 收集全部, 选第一个已连接的）。
  - 新增 `safe_reload()`: 60 秒冷却, 过频直接跳过。
  - STA 已连接 + AP 健康时: 只静默同步 UCI channel, 不触发 `wifi reload`。
  - 仅在 AP 接口确实 DOWN 时才 reload。
  - 多 STA 时打印 level 0 WARNING。
  - 提取 helper: `is_sta_connected()` / `get_sta_channel()` / `all_ap_up()` / `now_ts()`。
- **路由器侧注意事项**:
  - `sae-mixed` 加密需要 PMF (Protected Management Frames), 部分旧 Android/IoT 设备会直接报"密码错误"而非"不支持此加密"。若遇到密码正确但连不上, 降为 `psk2` 排查客户端兼容性。
  - radio1 上 AP 和 STA 必须同信道。STA 连到上游的信道决定了整个 radio 的信道, AP 自动跟随。UCI channel 只在不连 STA 时生效。

### 📝 Session: 2026-06-28 (wifi-monitor 新增 sta 选项 — commit b7c7fff)

- **目标**: 用户使用 mwan3 聚合两个同频 STA 时, 可指定只监控其中一个, 另一个不受干扰。
- **修改**:
  - 配置新增 `option sta ''` (留空=自动检测第一个已连接的 STA)。
  - 脚本: 若指定了 `sta` 则只监控该 STA section, 指定错误跳过本轮并报错。
  - LuCI 新增下拉菜单, 动态列出所有 mode=sta 的 wifi-iface。
  - 中文翻译同步更新。
- **路由器使用方法**:
  ```bash
  uci set wifi-monitor.config.sta='wifinet2'
  uci set wifi-monitor.config.enabled='1'
  uci commit wifi-monitor
  ```

### 📝 Session: 2026-06-25 (修改编译计划)
* **目标**: 将 GitHub Actions 自动化编译计划配置为北京时间每日早 5 点。
* **修改内容**:
  * 修改 [.github/workflows/openwrt-builder.yml](file:///Users/noxsk/Git/tr3000/.github/workflows/openwrt-builder.yml)：
    * 在 `on` 触发器中新增 `schedule` 字段，填入 `0 21 * * *` 的 cron 表达式（对应北京时间 UTC+8 的早 5:00）。
* **成果**: 实现了无人值守的每日北京时间清晨 5 点自动开始固件编译。

### 📝 Session: 2026-06-25 (定制 README 说明)
* **目标**: 更新 [README.md](file:///Users/noxsk/Git/tr3000/README.md) 描述，规范自用存档声明并指向实际的 GitHub 仓库地址。
* **修改内容**:
  * 修改 [README.md](file:///Users/noxsk/Git/tr3000/README.md)：
    * 更新仓库的 badges 指向 `https://github.com/noxsk/tr3000`。
    * 添加自用声明：“本项目为自用仓库，源码来自互联网（基于 Lean 的 OpenWrt 源码及 P3TERX 的 Actions-OpenWrt 编译模板），仅用于存档与 GitHub Actions 固件云端云编译。”
* **成果**: README 内容规范化，并清楚定义了仓库属性和使用目的。

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
- wifi-monitor 新增 `sta` 选项：可指定监控特定 STA 接口，配合 mwan3 多链路聚合使用时互不干扰。

#### Changed
- 将 [openwrt-builder.yml](file:///Users/noxsk/Git/tr3000/.github/workflows/openwrt-builder.yml) 编译计划修改为北京时间每日早 5 点（UTC 时间前一日晚 21 点）自动执行。
- 更新了 [README.md](file:///Users/noxsk/Git/tr3000/README.md) 说明，声明为自用仓库并且源码来自互联网，仅用于存档编译。
- 自定义了设备 LED 的默认启动行为（电源红灯常亮，状态白灯在局域网有网络数据时闪烁；在 [diy-part2.sh](file:///Users/noxsk/Git/tr3000/diy-part2.sh) 中以 Python 脚本处理）。
- 将默认 NTP 时间同步服务器修改为国内及苹果的 NTP 组（在 [diy-part2.sh](file:///Users/noxsk/Git/tr3000/diy-part2.sh) 中以 Python 脚本处理）。
- 将默认网页后台主题由 Bootstrap 更换为 Argon (`luci-theme-argon`)（在 [TR3000V1_MOD.config](file:///Users/noxsk/Git/tr3000/TR3000V1_MOD.config) 和 [diy-part2.sh](file:///Users/noxsk/Git/tr3000/diy-part2.sh) 中配置）。
- 将固件的默认局域网 (LAN) 网关 IP 变更为 `192.168.2.1`（在 [diy-part2.sh](file:///Users/noxsk/Git/tr3000/diy-part2.sh) 中通过 sed 命令进行默认值修改）。

#### Removed
- 彻底从编译配置中移除了 PassWall 科学上网插件及其所有残留的子依赖（如 Shadowsocks-Rust 服务端、SingBox、V2ray Geoview 选项）。
- 删除了 256MB RAM 版本的编译配置文件 `TR3000V1_256M.config`。

#### Fixed
- 修复 `luci-app-nat66` 和 `luci-app-wifi-monitor` 编译失败：移除无效 `PKG_BUILD_DEPENDS`, po2lmo 从 Build/Compile (硬路径 `STAGING_DIR_HOST` 错误) 移到 Package/install (直接用 `po2lmo` 命令)。
- 重写 `wifi-monitor.sh`：修复多 STA 下 wpa_supplicant deinit 死循环导致 WiFi 反复断开；新增 `safe_reload()` 60 秒冷却；STA 连接时仅静默同步 UCI 不再 reload；追踪全部 STA 不再只取最后一个。

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
4. **WiFi / 无线关键注意事项**：
   - **MT7981 (mt76) 多 STA 冲突**: 同一 radio 上配置多个 STA 连同一 AP 时, wpa_supplicant 会触发 `nl80211: deinit` 重置整张网卡, 导致 AP 和 STA 同时断开。如需多 STA (如 mwan3 聚合), 可用 wifi-monitor 的 `sta` 选项只监控其中一个。
   - **sae-mixed 兼容性**: WPA2/WPA3 混合模式需要 PMF (Protected Management Frames)。部分旧 Android/IoT 设备会直接报"密码错误"。排查时先降为 `psk2` 确认非加密兼容性问题。
   - **共享 radio 信道规则**: radio 上 AP 和 STA 必须同信道。STA 连到上游 AP 的信道决定了整个 radio 的实际信道, AP 自动跟随。UCI `channel` 设置仅在无 STA 连接时生效。wifi-monitor 在 STA 已连接且 AP 健康时只静默同步 UCI, 不触发 reload。
   - **wifi-monitor 编译注意**: 自定义 LuCI 包的 po2lmo 调用应放在 `Package/install` 段直接用 `po2lmo` 命令（不写硬路径）, 不要放在 `Build/Compile` 段。`PKG_BUILD_DEPENDS:=luci-base/host` 在 LEDE 构建系统中不被识别, 无效。

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
