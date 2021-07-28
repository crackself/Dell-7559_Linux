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
COMMON_FLAGS="-march=native -O2 -pipe"
CFLAGS="${COMMON_FLAGS}"
CXXFLAGS="${COMMON_FLAGS}"
FCFLAGS="${COMMON_FLAGS}"
FFLAGS="${COMMON_FLAGS}"
MAKEOPTS="-j3"

CPU_FLAGS_X86="aes avx avx2 f16c fma3 mmx mmxext pclmul popcnt rdrand sse sse2 sse3 sse4_1 sse4_2 ssse3"
CHOST="x86_64-pc-linux-gnu"

del="-bindist -debug -doc -test -handbook -nls -accessibility -mdev -consolekit -dhcpcd -netifrc -oss -gpm -iptables -bluetooth -pulseaudio"
kde="-gnome-shell -gnome -gnome-keyring -gtk -systemd kde"
dwm="-gnome-shell -gnome -gnome-keyring -gtk -systemd -kde -qt4 -qt5"
base="lm-sensors udev icu minizip blkid acpi dbus policykit elogind udisks http2"
add="iwd wifi ppp dhclient networkmanager usb alsa audio sudo git"
desktop="X cjk jack vdpau vaapi"
Media="aac ao dts dvd encode ffmpeg flac jbig jpeg jpeg2k mp3 lame mp4 tiff gif png mpeg svg cdr mms"
USE="${del} ${dwm} ${base} ${add} ${desktop}"

VIDEO_CARDS="intel i965 iris nvidia"
ALSA_CARDS="hda-intel"
INPUT_DEVICES="libinput"
GRUB_PLATFORMS="efi-64"
ACCEPT_LICENSE="*"
ACCEPT_KEYWORDS="~amd64"

L10N="en-US zh-CN en zh"
AUTO_CLEAN="yes"

LLVM_TARGETS="X86"

# NOTE: This stage was built with the bindist Use flag enabled
PORTDIR="/var/db/repos/gentoo"
DISTDIR="/var/cache/distfiles"
PKGDIR="/var/cache/binpkgs"

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
### 非Gentoo系统需要
```
test -L /dev/shm && rm /dev/shm && mkdir /dev/shm 
mount --types tmpfs --options nosuid,nodev,noexec shm /dev/shm 
chmod 1777 /dev/shm
```
or by one line:
```
mount --types proc /proc /mnt/gentoo/proc && mount --rbind /sys /mnt/gentoo/sys && mount --make-rslave /mnt/gentoo/sys && mount --rbind /dev /mnt/gentoo/dev && mount --make-rslave /mnt/gentoo/dev

chroot /mnt/gentoo /bin/bash && source /etc/profile && export PS1="(chroot) ${PS1}"
```

### EFI partition mount on /boot/efi
`mount /dev/sda1 /boot/efi`

### config and build system

```
emerge-webrsync
emerge --sync {Not neceesary}

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
/dev/sda1   /boot/efi   vfat  defaults  1 2
/dev/sdb3   /           ext4   defaults 0 1
```
#### More about fstab
`blkid` for display partition's UUID
when using UUID, replace `/dev/sdaX` by `UUID=xxx-xxxx`

### install GRUB UEFI bootloader
#### need to mount EFI partiton on `/boot/efi`
```
mount /dev/sda1 /boot/efi
emerge --ask --verbose sys-boot/grub:2 sys-boot/os-prober
```
#### For UEFI:
```
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Gentoo
or some machine need removable lable:
grub-install --target=x86_64-efi --efi-directory=/boot/efi --removable --bootloader-id=Gentoo
grub-mkconfig -o /boot/grub/grub.cfg
```
#### For BIOS bootloader:
```
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
```
### Manage Users
```
passwd root

useradd -m -G users,wheel,portage,usb,video [your user name]
passwd [your user name]
```
### Setting Host name
```
nano -w /etc/conf.d/hostname
# 设置主机名变量，选择主机名
hostname="Gentoo"
```
### Setting locale
```
echo "Asia/Shanghai" > /etc/timezone
emerge --config sys-libs/timezone-data

nano -w /etc/locale.gen

en_US ISO-8859-1
en_US.UTF-8 UTF-8
zh_CN GBK 
zh_CN.UTF-8 UTF-8

locale-gen
eselect locale list
eselect locale set X
```

### Install specially Wireless Driver for BCM94352Z
```
emerge --ask broadcom-sta iw wpa_supplicant dialog
```
### Install base Desktop(Optional)
```
emerge --ask xorg-server xinit kde-plasma/plasma-desktop powerdevil bluedevil systemsettings plasma-systemmonitor plasma-nm plasma-kmix(或者plasma-pa) kde-apps/dolphin alacritty wqy-microhei
```

### Install FULL KDE-PLASMA Desktop(Optional)
`emerge --ask kde-plasma/plasma-meta`

### exit and umount
```
退出chroot环境并unmount全部已持载分区：
exit && umount -l /mnt/gentoo/dev{/shm,/pts,} && umount -R /mnt/gentoo
```


Build Gentoo Kernel on VPS(KVM machine)
--
```
cd /usr/src/linux
make menuconfig
And then configure these things:

Gentoo Linux --->
   Support for init systems, system and service managers --->
      [*] systemd

Processor type and features  --->
     [*] Linux guest support --->
         [*] Enable Paravirtualization code
         [*] KVM Guest support (including kvmclock) Device Drivers  --->
     Virtio drivers  --->
         <*>   PCI driver for virtio devices
     [*] Block devices  --->
         <*>   Virtio block driver
     SCSI device support  --->
         [*] SCSI low-level drivers  --->
             [*]   virtio-scsi support
     [*] Network device support  --->
         [*] Network core driver support
             <*>   Virtio network driver

File systems --->
    <*> F2FS filesystem support #You can use any file system you like.
```

>> https://www.jianshu.com/p/31f7ff6ee3d4

>> https://blog.yangmame.org/Gentoo%E5%AE%89%E8%A3%85%E6%95%99%E7%A8%8B.html

>> https://wiki.gentoo.org/wiki/Handbook:AMD64/zh-cn

>> https://wiki.gentoo.org/wiki/Dell_XPS_13_9343 (For configure wireless and bluetooth)

>> https://jerryding.site/installing-gentoo-on-vps-and-build-up-a-website/  (complie kernel for VPS)
