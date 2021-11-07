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



$(eval $(generic-package))
