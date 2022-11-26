# RPi-Jukebox-RFID-buildroot-package
RPi-Jukebox-RFID-buildroot-package


## UseCase
I created this repo because we wanted to use Jukebox for RPi Zero W but unfortunately the start up timing was to slow for usage with children.
So we tried to create a buildroot package but it was harder than expected and the usage of a microcontroller (ESP8266, ...) was easier.
But because of easy update possibility we try again to create a small buildroot setup for the rasperrypi zero.

## ToDo
1. Download and unzip buildroot 
   [BuildRoot Documentation](https://buildroot.org/downloads/manual/manual.html)
1. Run default config for raspberry pi zero w
   ```
   make raspberrypi0w_defconfig
   ```
1. Add your config for raspberrypi

    ```Enable Compiler Cache in Build Options```

    ```Enable WCHAR in Toolchain```

    ```Enable NODEJS in Target Packages Interpreters```

    ```Hardware Handling -> Firmware -> rpi-wifi-firmware```

   ```Networking applications -> wpa_supplicant```
   
   ```Networking applications -> wpa_supplicant - Enable 80211 support```
   
   ```Networking applications -> dropbear```
   
   ```Networking applications -> openssh```
   


1. Clone this repo inside the package folder of buildroot
   ```
   git clone https://github.com/net-attack/RPi-Jukebox-RFID-buildroot-package.git rpi-phoniebox
   ```
1. Add package to `package\Config.in` end of file:
   ```
   menu "Phoniebox"
      source "package/rpi-phoniebox/Config.in"
   endmenu
   ```
   Ensure to have a empty newline in the config files. 
   This lead to errors while running make menuconfig
1. Run `make menuconfig` and select `Phoniebox` 
1. Run `make`





## Open Issues:
1. Need to patch the linux_custom script folder:
   Replace in `output\build\linux_custom\scripts\dtc\dtc-lexer.l` the line `YYLTYPE yylloc;` with `extern YYLTYPE yylloc;`
