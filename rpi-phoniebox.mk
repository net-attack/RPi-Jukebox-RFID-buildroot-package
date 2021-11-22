################################################################################
#
# Phonibox
#
################################################################################

# Use a tag or a full commit ID
#PHONIEBOX_SITE = https://github.com/MiczFlor/RPi-Jukebox-RFID
RPI_PHONIEBOX_VERSION = origin/future3/develop
RPI_PHONIEBOX_SITE = https://github.com/MiczFlor/RPi-Jukebox-RFID
RPI_PHONIEBOX_SITE_METHOD = git



RPI_PHONIEBOX_INSTALL_STAGING = YES


ifeq ($(BR2_PACKAGE_RPI_PHONIEBOX_WEBAPP),y)
define RPI_PHONIEBOX_BUILD_CMDS
	cd $(@D)/src/webapp; $(NPM) ci --prefer-offline --no-audit --production
	cd $(@D)/src/webapp; rm -rf build
	cd $(@D)/src/webapp; $(NPM) run build
endef
endif

ifeq ($(BR2_PACKAGE_RPI_PHONIEBOX_WEBAPP),y)
define RPI_PHONIEBOX_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/opt/webapp/build
	cp -r $(@D)/src/webapp/build $(TARGET_DIR)/opt/webapp/build;
	mkdir -p $(TARGET_DIR)/etc/nginx/sites-available
	cp -f ${@D}/resources/default-settings/nginx.default $(TARGET_DIR)/etc/nginx/sites-available/default
endef
endif



$(eval $(generic-package))

