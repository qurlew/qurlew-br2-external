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

define QURLEW_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(QURLEW_ENV) $(HOST_DIR)/usr/bin/qmake)
endef

define QURLEW_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(QURLEW_ENV) $(MAKE) -C $(@D)
endef

define QURLEW_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 -D $(@D)/src/qurlew \
		$(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))
