include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-nat66
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_LICENSE:=MIT
PKG_MAINTAINER:=Antigravity AI

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-nat66
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=LuCI support for NAT66 (IPv6 NAT) configuration
  DEPENDS:=+luci-base
  PKGARCH:=all
endef

define Package/luci-app-nat66/description
  LuCI Support for one-click NAT66 config.
endef

define Build/Compile
endef

define Package/luci-app-nat66/install
	$(INSTALL_DIR) $(1)/usr/share/luci/menu.d
	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	$(INSTALL_DIR) $(1)/www/luci-static/resources/view
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_BIN) ./root/etc/init.d/nat66 $(1)/etc/init.d/nat66
	$(INSTALL_CONF) ./root/etc/config/nat66 $(1)/etc/config/nat66
	$(INSTALL_DATA) ./root/usr/share/luci/menu.d/luci-app-nat66.json $(1)/usr/share/luci/menu.d/luci-app-nat66.json
	$(INSTALL_DATA) ./root/usr/share/rpcd/acl.d/luci-app-nat66.json $(1)/usr/share/rpcd/acl.d/luci-app-nat66.json
	$(INSTALL_DATA) ./root/www/luci-static/resources/view/nat66.js $(1)/www/luci-static/resources/view/nat66.js
	$(STAGING_DIR_HOST)/bin/po2lmo ./po/zh_Hans/nat66.po $(1)/usr/lib/lua/luci/i18n/nat66.zh-cn.lmo
	$(STAGING_DIR_HOST)/bin/po2lmo ./po/zh_Hans/nat66.po $(1)/usr/lib/lua/luci/i18n/nat66.zh-hans.lmo
endef

$(eval $(call BuildPackage,luci-app-nat66))

