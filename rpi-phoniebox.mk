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

RPI_PHONIEBOX_DEPENDENCIES += wpa_supplicant
RPI_PHONIEBOX_DEPENDENCIES += dhcp
RPI_PHONIEBOX_DEPENDENCIES += nodejs

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
	mkdir -p $(TARGET_DIR)/usr/html
	rm -r $(TARGET_DIR)/usr/html/*
	cp -r $(@D)/src/webapp/build/* $(TARGET_DIR)/usr/html/;
	cp package/busybox/S10mdev ${TARGET_DIR}/etc/init.d/S10mdev
	chmod 755 ${TARGET_DIR}/etc/init.d/S10mdev
	cp package/busybox/mdev.conf ${TARGET_DIR}/etc/mdev.conf
	
	cp package/rpi-phoniebox/interfaces ${TARGET_DIR}/etc/network/interfaces
	cp package/rpi-phoniebox/wpa_supplicant.conf ${TARGET_DIR}/etc/wpa_supplicant.conf
	#cp package/rpi-phoniebox/sshd_config ${TARGET_DIR}/etc/ssh/sshd_config
endef
endif



$(eval $(generic-package))

