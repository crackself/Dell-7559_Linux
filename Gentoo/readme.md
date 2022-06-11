### stage3文件准备
下载stage3压缩包https://www.gentoo.org/downloads/
      
`cd /mnt/gentoo`     
`tar vxpf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner`

### 添加镜像源（可选）
`mkdir /mnt/gentoo/etc/portage/repos.conf`      
`nano /mnt/gentoo/etc/portage/repos.conf/gentoo.conf`
```
[gentoo]
location = /usr/portage
sync-type = rsync
sync-uri = rsync://rsync.mirrors.ustc.edu.cn/gentoo-portage/
auto-sync = yes
```

#### 设置portage make.conf

`nano /mnt/gentoo/etc/portage/make.conf`
```
# These settings were set by the catalyst build script that automatically
# built this stage.
# Please consult /usr/share/portage/config/make.conf.example for a more
# detailed example.
COMMON_FLAGS="-march=native -O3 -pipe"
CFLAGS="${COMMON_FLAGS}"
CXXFLAGS="${COMMON_FLAGS}"
FCFLAGS="${COMMON_FLAGS}"
FFLAGS="${COMMON_FLAGS}"
LDFLAGS="${COMMON_FLAGS}"

MAKEOPTS="-j4"
NINJAOPTS="-j4"

CPU_FLAGS_X86="aes avx avx2 f16c fma3 mmx mmxext pclmul popcnt rdrand sse sse2 sse3 sse4_1 sse4_2 ssse3"
CHOST="x86_64-pc-linux-gnu"

del="-busybox -bindist -debug -doc -gtk-doc -test -handbook -nls -accessibility -mdev -consolekit -netifrc -oss -gpm -pulseaudio -vlc -ppp"
kde="-gnome-shell -gnome -gnome-keyring -gtk -systemd kde"
dwm="-gnome-shell -gnome -gnome-keyring -gtk -gtk2 -gtk3 -systemd -kde -qt4 -qt5"
gnome="-qt4 -qt5 -kde -systemd gtk gnome"
base="udev icu blkid acpi dbus policykit elogind udisks"
add="bluetooth iwd wifi networkmanager usb alsa sudo git"
desktop="X cjk jack vdpau vaapi wayland gles2"
media="aac encode ffmpeg flac jbig jpeg jpeg2k mp3 lame mp4 tiff gif png mpeg svg"
dev="fortran lto pgo graphite openmp"
USE="${del} ${base} ${add} ${dev} ${media} ${desktop}"

VIDEO_CARDS="intel i965 iris nvdia"
ALSA_CARDS="hda-intel"
INPUT_DEVICES="libinput"
GRUB_PLATFORMS="efi-64"
ACCEPT_LICENSE="*"
ACCEPT_KEYWORDS="~amd64"
#UNITY_GLOBAL_KEYWORD_UNMASK=yes

L10N="en-US zh-CN en zh"
#AUTO_CLEAN="yes"

#PYTHON_TARGETS="python3_10"
#PYTHON_SINGLE_TARGET="python3_10"

# NOTE: This stage was built with the bindist Use flag enabled
PORTDIR="/var/db/repos/gentoo"
DISTDIR="/var/cache/distfiles"
PKGDIR="/var/cache/binpkgs"

# This sets the language of build output to English.
# Please keep this setting intact when reporting bugs.
LC_MESSAGES=C

#FEATURES="-strict -assume-digests -sign"
```

### 切换root环境
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

chroot /mnt/gentoo /bin/bash
source /etc/profile && export PS1="(chroot) ${PS1}"
```

### 挂载EFI分区
`mkdir /boot/efi`
`mount /dev/sda1 /boot/efi`

### 配置基本系统
```
emerge-webrsync

eselect profile list
eselect profile set 1   # 1 以最小USE，配合自定的make.conf即可

emerge --ask --verbose --update --deep --newuse @world （emerge -avuDN @world）

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

### 安装GRUB引导
#### need to mount EFI partiton on `/boot/efi`
```
emerge --ask --verbose sys-boot/grub sys-boot/os-prober
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
### 添加用户账户
```
passwd root

useradd -m -G users,wheel,portage,usb,video,plugdev [your user name]
passwd [your user name]
```
### 设置主机名
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
### 安装字体
```
media-fonts/fontawesome    图标字体
media-fonts/noto-cjk       中日韩字体集
media-fonts/wqy-zenhei     中文字体
```
### DW1560特别驱动:
- BroadCom BCM94352Z wireless driver: `broadcom-sta`
- Bluetooth firmware: `broadcom-bt-firmware`, Bluetooth audio need pulseaudio
```
emerge --ask broadcom-sta broadcom-bt-firmware
```
### 精简安装KDE Plasma桌面
```
emerge --ask xorg-server xinit kde-plasma/plasma-desktop powerdevil bluedevil systemsettings plasma-systemmonitor plasma-nm plasma-pa kde-apps/dolphin kconsole wqy-microhei
```
### KDE组件
plasma-kmix、plasma-pa：KDE音频管理，两者功能相似，但前者不依赖pulseaudio
使用蓝牙音频推荐pulseaudio
pulseaudio无法在root用户环境开启

### 安装全套KDE Plasma桌面
`emerge --ask kde-plasma/plasma-meta`

### 退出ch-root环境
```
退出chroot环境并unmount全部已持载分区：
exit && umount -l /mnt/gentoo/dev{/shm,/pts,} && umount -R /mnt/gentoo
```
## 常见问题解决
### 开机内核pkcs8_key_parse加载报错
屏蔽模块自动加载
      /usr/lib/modules-load.d/pkcs8.conf

### 还原备份系统后无法解锁屏幕
重新安装pam：
      emerge -a pam

### 安装SDDM无法启动，只显示黑屏和鼠标
      按照`/var/log/sddm.log`的错误，需要创建`/var/lib/sddm`目录
      sudo mkdir /var/lib/sddm

###  屏幕亮度重启后无法保存
      emerge --ask acpilight
      rc-service acpilight start
      rc-service acpilight restart
      rc-update add acpilight boot

### qemu TPM2.0模拟及硬件直通
均需使用带vm或带qemu的内核配置文件
安装qemu及图形化管理(virt-manager需要开启gtk USE)：
      sudo emerge --ask app-emulation/qemu app-emulation/virt-manager app-crypt/swtpm
QEMU模拟TPM2.0需要安装wtpm          
硬件直通需要解除主系统对硬件的使用（虚拟机独占）

### wayland 支持
修改`/etc/portage/make.conf` 添加`wayland gles2` USE标记:
      desktop="X cjk jack vdpau vaapi wayland gles2"

### KDE Plasma系统主题美化
      全局主题：WhiteSur-kde(https://github.com/vinceliuice/WhiteSur-kde)          
      图标主题：WhiteSur-icon-theme(https://github.com/vinceliuice/WhiteSur-kde)         
      软件：Latte Dock(Dock状态栏)、Kvantum（全局主题调整）          
      emerge --ask kde-misc/latte-dock x11-themes/kvantum

### VPS(KVM machine) 内核模块需求(推荐VPS参考)

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
