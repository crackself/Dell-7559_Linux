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
#### /etc/portage/make.conf
```
nano /mnt/gentoo/portage/make.conf

# GCC
CFLAGS="-march=skylake -O2 -pipe"
CXXFLAGS="${CFLAGS}"
CPU_FLAGS_X86="aes avx avx2 fma3 mmx mmxext popcnt sse sse2 sse3 sse4_1 sse4_2 ssse3"
MAKEOPTS="-j5"

# USE
# set your desktop in DESKTOP , etc kde or gnome
NEED="X aac acpi alsa ao bash_completion bluetooth bzip2 chromium cdr cjk cups curl dts dvd encode ffmpeg flac geoip gif git gpm gzip hddtemp javascript jack jbig jpeg jpeg2k lame lm_sensors lzma mmap mms mp3 mp4 mpeg multilib networkmanager nls pdf plasma png python raw sudo sockets socks5 sound ssl svg tiff udev udisks unicode usb upower upnp 
wifi wmf zip zlib"
REMOVE="-bindist -grub -plymouth -systemd consolekit -modemmanager -gnome-shell -gnome -gnome-keyring -nautilus -modules -qt5"
DESKTOP="" 
USE="${NEED} ${REMOVE} ${DESKTOP}"

# Portage
PORTDIR="/usr/portage"
DISTDIR="${PORTDIR}/distfiles"
PKGDIR="${PORTDIR}/packages"
# GENTOO_MIRRORS="https://mirrors.tuna.tsinghua.edu.cn/gentoo/"
GENTOO_MIRRORS="https://mirrors.ustc.edu.cn/gentoo/"

ACCEPT_LICENSE="*"

# Language
L10N="en-US zh-CN en zh"
LINGUAS="en_US zh_CN en zh"

# Else
VIDEO_CARDS="intel i965 nvidia"
GRUB_PLATFORMS="efi-64"

QEMU_SOFTMMU_TARGETS="alpha aarch64 arm i386 mips mips64 mips64el mipsel ppc ppc64 s390x sh4 sh4eb sparc sparc64 x86_64"
QEMU_USER_TARGETS="alpha aarch64 arm armeb i386 mips mipsel ppc ppc64 ppc64abi32 s390x sh4 sh4eb sparc sparc32plus sparc64"

# This sets the language of build output to English.
# Please keep this setting intact when reporting bugs.
LC_MESSAGES=C
```
### 进入新环境

```
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
```
```

chroot /mnt/gentoo /bin/bash
ource /etc/profile
export PS1="(chroot) ${PS1}"
```
### config and build system
```
emerge-webrsync
eselect profile list
eselect profile set X

emerge --ask --verbose --update --deep --newuse @world
- ebuild source location is usr/portage/distfiles
echo "Asia/Shanghai" > /etc/timezone
emerge --config sys-libs/timezone-data

nano -w /etc/locale.gen
locale-gen
eselect locale list
eselect locale set X
env-update && source /etc/profile && export PS1="(chroot) $PS1"

### 配置Linux内核
emerge --ask sys-kernel/gentoo-sources

cd /usr/src/linux
make menuconfig
make && make modules_install
make install

merge --ask sys-kernel/genkernel
genkernel --install initramfs

nano -w /etc/fstab

```


### install GRUB UEFI bootloader
#### need to mount EFI partiton on `/boot/efi`
```
emerge --ask --verbose sys-boot/grub:2

grub-install --target=x86_64-efi --efi-directory=/boot/efi
```
### exit and umount
```
退出chroot环境并unmount全部已持载分区：
exit
umount -l /mnt/gentoo/dev{/shm,/pts,}
umount -R /mnt/gentoo
```

>> https://blog.yangmame.org/Gentoo%E5%AE%89%E8%A3%85%E6%95%99%E7%A8%8B.html
>> https://wiki.gentoo.org/wiki/Handbook:AMD64/zh-cn
>> https://wiki.gentoo.org/wiki/Dell_XPS_13_9343 (For configure wireless and bluetooth)
