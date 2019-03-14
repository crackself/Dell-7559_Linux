### BroadCom BCM94352Z wireless driver: Broadcom-sta (broadcom-wl)

```
USE:
X aac acpi alsa ao bash_completion bluetooth bzip2 cdr cjk cups curl dts dvd encode ffmpeg flac geoip gif git gpm gzip hddtemp javascript jack jbig jpeg jpeg2k kde lame lm_sensors lzma mmap mms mp3 mp4 mpeg multilib networkmanager nls pdf plasma png python qt5 raw sockets socks5 sound ssl svg tiff udev udisks unicode usb upower upnp 
wifi wmf zip zlib zsh-completion
-gnome -systemd -gtk
```
### EFI partition mount on /boot/efi

#### install grub2 for bootloader
```
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Gentoo
grub-mkconfig -o /boot/grub/grub.cfg
```
### setting mirror
```
mkdir /mnt/gentoo/etc/portage/repos.conf
nano /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
```
```
[gentoo]
location = /usr/portage
sync-type = rsync
#sync-uri = rsync://mirrors.tuna.tsinghua.edu.cn/gentoo-portage/
sync-uri = rsync://rsync.mirrors.ustc.edu.cn/gentoo-portage/
auto-sync = yes
```
#### etc/portage/make.conf
```
# GCC
CFLAGS="-march=skylake -O2 -pipe"
CXXFLAGS="${CFLAGS}"
CHOST="x86_64-pc-linux-gnu"
CPU_FLAGS_X86="aes avx avx2 fma3 mmx mmxext popcnt sse sse2 sse3 sse4_1 sse4_2 ssse3"
MAKEOPTS="-j5"

# USE
SUPPORT="pulseaudio X aac acpi alsa ao bash-completion bluetooth bzip2 cdr cjk cups curl dts dvd dbus debug encode ffmpeg flac geoip gif git gpm gzip hddtemp javascript jack jbig jpeg jpeg2k lame lm_sensors lzma mmap mms mp3 mp4 mpeg multilib networkmanager nls pdf plasma png python qt5 raw sockets socks5 sound ssl svg tiff udev udisks unicode usb upower upnp 
wifi wmf zip zlib zsh-completion chromium"
FUCK="-bindist -grub -plymouth -systemd consolekit -modemmanager -gnome-shell -gnome -gnome-keyring -nautilus -modules"
ELSE="client icu sudo python"

USE="${SUPPORT} ${DESKTOP} ${FUCK} ${ELSE}"

# Portage
PORTDIR="/usr/portage"
DISTDIR="${PORTDIR}/distfiles"
PKGDIR="${PORTDIR}/packages"
# GENTOO_MIRRORS="https://mirrors.tuna.tsinghua.edu.cn/gentoo/"
GENTOO_MIRRORS="https://mirrors.ustc.edu.cn/gentoo/"

ACCEPT_KEYWORDS="~amd64"
ACCEPT_LICENSE="*"

# Language
L10N="en-US zh-CN en zh"
LINGUAS="en_US zh_CN en zh"

# Else
VIDEO_CARDS="intel i965 nvidia"

QEMU_SOFTMMU_TARGETS="alpha aarch64 arm i386 mips mips64 mips64el mipsel ppc ppc64 s390x sh4 sh4eb sparc sparc64 x86_64"
QEMU_USER_TARGETS="alpha aarch64 arm armeb i386 mips mipsel ppc ppc64 ppc64abi32 s390x sh4 sh4eb sparc sparc32plus sparc64"
```

>> https://blog.yangmame.org/Gentoo%E5%AE%89%E8%A3%85%E6%95%99%E7%A8%8B.html
>> https://wiki.gentoo.org/wiki/Handbook:AMD64/zh-cn
>> https://wiki.gentoo.org/wiki/Dell_XPS_13_9343 (For configure wireless and bluetooth)
