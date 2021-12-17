### DW1560:
  
  [Build Wi-Fi driver](https://www.kernel.org/doc/html/latest/kbuild/modules.html) [Bluetooth](https://wiki.archlinux.org/title/Dell_XPS_13_(9343)#Bluetooth)

  before build Wi-Fi driver, build kernel from source, patch for Wi-Fi src

    patch -p1 -i ../files/XXXX.patch

### All used firmware
  firmware install into `/lib/firmware` 
  
  tarball frome Gentoo `sys-kernel/linux-firmware`
  
  build firmware into kernel, add bellow to kernel configuration
  ```
  CONFIG_PREVENT_FIRMWARE_BUILD=y
  CONFIG_EXTRA_FIRMWARE="rtl_nic/rtl8168g-3.fw i915/skl_dmc_ver1_27.bin regulatory.db regulatory.db.p7s brcm/BCM20702A0-0a5c-216f.hcd"
  CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"
  ```
```
     Realtek LAN:  rtl_nic/rtl8168g-3.fw
Intel HD Graphic: i915/skl_dmc_ver1_27.bin
        Wireless: regulatory.db
                  regulatory.db.p7s
       Bluetooth:  brcm/BCM20702A0-0a5c-216f.hcd
```
### How to find which is the correct firmware
 issue `dmesg` in terminal for details
```
dmesg | grep firmware
dmesg | grep error
```
### Build QT5 with qtx11extras module
```
# build with x11extras
mkdirqt5-build && cd qt5-build

../configure	-prefix $QT5PREFIX		\
		-sysconfdir /etc/xdg		\
		-confirm-license		\
		-opensource			\
		-nomake examples		\
		-skip qtwebengine		\
		-syslog				\
		-dbus-linked			\
		-openssl-linked			\
		-system-harfbuzz		\
		-system-sqlite			&&
make


# x11extras will bypass when building
./configure -prefix $QT5PREFIX                        \
            -sysconfdir /etc/xdg                      \
            -confirm-license                          \
            -opensource                               \
            -dbus-linked                              \
            -openssl-linked                           \
            -system-harfbuzz                          \
            -system-sqlite                            \
            -nomake examples                          \
            -no-rpath                                 \
            -syslog                                   \
            -skip qtwebengine
```
