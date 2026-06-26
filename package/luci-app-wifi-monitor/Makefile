include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-wifi-monitor
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_LICENSE:=MIT
PKG_MAINTAINER:=Antigravity AI

include $(INCLUDE_DIR)/package.mk

PKG_BUILD_DEPENDS:=luci-base/host

define Package/luci-app-wifi-monitor
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=LuCI support for Wi-Fi Channel Monitor & Sync
  DEPENDS:=+iwinfo +iw +jsonfilter
  PKGARCH:=all
endef

define Package/luci-app-wifi-monitor/description
  Monitors and synchronizes channels for wireless interfaces operating in dual STA/AP modes to prevent local AP drops when upstream channels drift.
endef

define Build/Compile
endef

define Package/luci-app-wifi-monitor/install
	$(INSTALL_DIR) $(1)/usr/share/luci/menu.d
	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	$(INSTALL_DIR) $(1)/www/luci-static/resources/view
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_BIN) ./root/etc/init.d/wifi-monitor $(1)/etc/init.d/wifi-monitor
	$(INSTALL_CONF) ./root/etc/config/wifi-monitor $(1)/etc/config/wifi-monitor
	$(INSTALL_BIN) ./root/usr/bin/wifi-monitor.sh $(1)/usr/bin/wifi-monitor.sh
	$(INSTALL_DATA) ./root/usr/share/luci/menu.d/luci-app-wifi-monitor.json $(1)/usr/share/luci/menu.d/luci-app-wifi-monitor.json
	$(INSTALL_DATA) ./root/usr/share/rpcd/acl.d/luci-app-wifi-monitor.json $(1)/usr/share/rpcd/acl.d/luci-app-wifi-monitor.json
	$(INSTALL_DATA) ./root/www/luci-static/resources/view/wifi-monitor.js $(1)/www/luci-static/resources/view/wifi-monitor.js
	$(STAGING_DIR_HOST)/bin/po2lmo ./po/zh_Hans/wifi-monitor.po $(1)/usr/lib/lua/luci/i18n/wifi-monitor.zh-cn.lmo
	$(STAGING_DIR_HOST)/bin/po2lmo ./po/zh_Hans/wifi-monitor.po $(1)/usr/lib/lua/luci/i18n/wifi-monitor.zh_Hans.lmo
endef

$(eval $(call BuildPackage,luci-app-wifi-monitor))
