### something need to know:
- BroadCom BCM94352Z wireless driver: Broadcom-sta (broadcom-wl)
- ebuild source location is usr/portage/distfiles rise up affter `emerge-webrsync`

### Prepar ebuild
#### get stage3 tarball and extra into your Dir.
```
cd /mnt/gentoo
tar vxpf stage3-*.tar.bz2 --xattrs-include='*.*' --numeric-owner
or
tar vxpf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner
```

### setting mirror
```
mkdir /mnt/gentoo/etc/portage/repos.conf
nano /mnt/gentoo/etc/portage/repos.conf/gentoo.conf

[gentoo]
location = /usr/portage
sync-type = rsync
sync-uri = rsync://rsync.mirrors.ustc.edu.cn/gentoo-portage/
auto-sync = yes
```

#### Edit make.conf
```
nano /mnt/gentoo/etc/portage/make.conf

# These settings were set by the catalyst build script that automatically
# built this stage.
# Please consult /usr/share/portage/config/make.conf.example for a more
# detailed example.
# GCC
CFLAGS="-march=skylake -O2 -pipe"
CXXFLAGS="${CFLAGS}"
CHOST="x86_64-pc-linux-gnu"
#CPU_FLAGS_X86="aes avx avx2 fma3 mmx mmxext popcnt sse sse2 sse3 sse4_1 sse4_2 ssse3"
MAKEOPTS="-j7"


# USE
Base="acpi bzip2 cups curl geoip gzip hddtemp lm_sensors lzma mmap multilib nls ncurses sudo sockets socks5 source ssl udev unicode upnp zip zlib"
Devel="bash_completion git javascript python"
Hardware="pulseaudio bluetooth sound wifi gpm jack usb"
Desktop="X cjk networkmanager chromium pdf udisks upower networkmanager dbus policykit udisks" 
Media="aac ao dts dvd encode ffmpeg flac jbig jpeg jpeg2k mp3 lame mp4 tiff gif png mpeg svg cdr mms"
# Remove="-bindis -plymouth -systemd -modemmanager -gtk -gnome-shell -gnome -gnome-keyring -nautilus -modules"

# if using systemd, it must remove "-systemd -modemmanager"
# if not necessary, DO NOT use "Remove"

#
# Do Carefully when using Remove items, make sure NOT CONFLICT.  etc. systemd need when using gnome desktop
# ${Base} ${Devel} ${Hardware} suggest using, ${Desktop} ${Media} suggest together
#

USE="${Base} ${Devel} ${Hardware} ${Desktop} ${Media}"

# Portage
PORTDIR="/usr/portage"
DISTDIR="${PORTDIR}/distfiles"
PKGDIR="${PORTDIR}/packages"
GENTOO_MIRRORS="https://mirrors.ustc.edu.cn/gentoo/"

ACCEPT_LICENSE="*"

# Language
#L10N="en-US zh-CN en zh"
#LINGUAS="en_US zh_CN en zh"

# Others
VIDEO_CARDS="intel i965 nvidia"
GRUB_PLATFORMS="efi-64"
ACCEPT_KEYWORDS="~amd64"

# QEMU_SOFTMMU_TARGETS="alpha aarch64 arm i386 mips mips64 mips64el mipsel ppc ppc64 s390x sh4 sh4eb sparc sparc64 x86_64"
# QEMU_USER_TARGETS="alpha aarch64 arm armeb i386 mips mipsel ppc ppc64 ppc64abi32 s390x sh4 sh4eb sparc sparc32plus sparc64"

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
source /etc/profile
export PS1="(chroot) ${PS1}"
```

### EFI partition mount on /boot/efi
`mount /dev/sda1 /boot/efi`

### config and build system

```
emerge-webrsync
emerge --sync

eselect profile list
eselect profile set 20   # 20 mark ad kde-plasma/systemd

emerge --ask --verbose --update --deep --newuse @world

echo "Asia/Shanghai" > /etc/timezone
emerge --config sys-libs/timezone-data

nano -w /etc/locale.gen
locale-gen
eselect locale list
eselect locale set X
env-update && source /etc/profile && export PS1="(chroot) $PS1"
```
### 配置Linux内核
```
emerge --ask sys-kernel/gentoo-sources

cd /usr/src/linux
make menuconfig
make && make modules_install
make install

emerge --ask sys-kernel/genkernel
genkernel --install initramfs

nano -w /etc/fstab
```


### install GRUB UEFI bootloader
#### need to mount EFI partiton on `/boot/efi`
```
emerge --ask --verbose sys-boot/grub:2 sys-boot/os-prober

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Gentoo
grub-mkconfig -o /boot/grub/grub.cfg
```
### Manage Users
```
passwd root

seradd -m -G users,wheel,portage,usb,video [your user name]
passwd [your user name]
```
### Install specially Wireless Driver for BCM94352Z
```
emerge --ask broadcom-sta iw wpa_supplicant dialog
```
### Install base Desktop(Optional)
```
emerge --ask xorg kde-plasma/plasma-desktop plasma-nm plasma-pa
```

### Install FULL KDE-PLASMA Desktop(Optional)
`emerge --ask kde-plasma/plasma-meta`

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
