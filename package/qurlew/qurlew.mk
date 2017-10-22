################################################################################
#
# qurlew
#
################################################################################

QURLEW_VERSION = 954aba2381e215e1666fe57a2747f0ee91a791c9
QURLEW_SITE = $(call github,qurlew,qurlew,$(QURLEW_VERSION))
QURLEW_LICENSE = GPL-3.0+
QURLEW_LICENSE_FILES = LICENCE
QURLEW_DEPENDENCIES = qt5webengine

define QURLEW_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D $(QURLEW_PKGDIR)/S99qurlew \
		$(TARGET_DIR)/etc/init.d/S99qurlew
endef

define QURLEW_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(QURLEW_PKGDIR)/qurlew.service \
		$(TARGET_DIR)/usr/lib/systemd/system/qurlew.service
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
	ln -sf ../../../../usr/lib/systemd/system/qurlew.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/qurlew.service
endef

define QURLEW_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(QURLEW_ENV) $(HOST_DIR)/usr/bin/qmake)
endef

define QURLEW_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(QURLEW_ENV) $(MAKE) -C $(@D)
endef

define QURLEW_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 -D $(@D)/src/qurlew $(QURLEW_PKGDIR)/qurlew-shell \
		$(TARGET_DIR)/usr/bin/
	grep -qsE '^/usr/bin/qurlew-shell' $(TARGET_DIR)/etc/shells \
		|| echo "/usr/bin/qurlew-shell" >> $(TARGET_DIR)/etc/shells
endef

$(eval $(generic-package))
