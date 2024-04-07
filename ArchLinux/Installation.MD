## 以下操作在LiveCD环境：
### 准备磁盘
```
mkfs.ext4 /dev/sda3
mount /dev/sda3 /mnt
```
### 安装基本系统：
```
pacstrap -i /mnt base grub efibootmgr sudo networkmanager sddm firefox alacritty plasma-desktop powerdevil bluedevil systemsettings plasma-systemmonitor plasma-nm plasma-pa dolphin kwrite
```
### 切换到chroot
`arch-chroot /mnt`
## 以下操作在chroot环境：
### 设置root密码
`passwd`
### 挂载EFI目录
```
mkdir /boot/efi
mount /dev/sda1 /boot/efi
```
### 安装GRUB引导记录
```
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Archlinux
```
### 添加用户并设置密码
```
useradd -m -G users,wheel,audio,video [your user name]
passwd [your user name]
```
### 安装通用内核
`pacman -S linux`
### 生成引导文件
`grub-mkconfig -o /boot/grub/grub.cfg`
### 启用NetowrkManager系统服务
`systemctl enable NetowrkManager`
### 至此，以最简洁的命令行操作安装一个完整可用的基础系统完成，重启机器后进行优化、个性化设置。重启后会默认引导至Archlinux, 可通过命令行登录系统进行后续操作。
### 登录普通用户后通过命令行设置.xinitrc默认引导plasma桌面
```
cat > ~/.xinitrc << "EOF"
export DESKTOP_SESSION=plasma
exec startplasma-x11
EOF
```
`或用nano编辑.xinitrc`
### 启动plasma
`startx`
## 以下操作在桌面环境,以root权限操作
### 设置主机名
```
cat > /etc/hostname << "EOF"
Archlinux
EOF
```
### 设置locale,取消注释以下条目
```
nano /etc/locale.gen

en_US ISO-8859-1
en_US.UTF-8 UTF-8
zh_CN GBK
zh_CN.UTF-8 UTF-8

locale-gen
nano /etc/locale.conf
LANG=en_US.UTF-8
```
### 设置额外环境变量(用户locale、输入法)
```
cat > /etc/profile.d/extrapath.sh << "EOF"
# Set custom CFLAGS
export CFLAGS="-march=native -O3 -pipe -fPIC"
export CXXFLAGS=$CFLAGS
export LDFLAGS=$CFLAGS
export OTHER_CFLAGS=$CFLAGS
export OTHER_CXXFLAGS=$CXXFLAGS
export OTHER_LDFLAGS=$LDFLAGS
export MAKEFLAGS='-j4'
export NINJAJOBS=4

# Set input method
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

EOF
```
### 设置wheel用户组root权限，方便sudo及挂载磁盘
```
cat > /etc/polkit-1/rules.d/50-udiskie.rules << "EOF"
/* Allow members of the wheel group to execute the defined actions
 * without password authentication, similar to "sudo NOPASSWD:"
 */
polkit.addRule(function(action, subject) {
    if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
         action.id == "org.freedesktop.udisks2.filesystem-mount-system") &&
        subject.isInGroup("wheel"))
    {
        return polkit.Result.YES;
    }
});
EOF
```
### 设置wheel用户组免输入root密码权限
`EDITOR=nano visudo`

```
## Same thing without a password
%wheel ALL=(ALL:ALL) NOPASSWD: ALL
```
### 开启内核自带的NTFS驱动以便挂载NTFS分区(须15.3以上内核)
```
cat >> /usr/sbin/mount.ntfs <<"EOF"
#!/bin/sh
exec mount -t ntfs3 "$@"
EOF
```
```
chmod -v 755 /usr/sbin/mount.ntfs

cat > /etc/udisks2/mount_options.conf << "EOF"
[defaults]
ntfs_defaults=uid=$UID,gid=$GID
EOF
```
## 最后精简编译内核
### （按照硬件定制，config文件参考 https://github.com/crackself/Dell-7559_Linux/tree/master/kernel_config）
### 成功通过定制的内核引导测试后，可卸载默认的linux内核
`pacman -Rsc linux`
### 精简修改/boot/grub/grub.cfg
`(nvidia-drm.modeset=1 开启nvidia驱动，quiet：不显示跑码)`

```cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod part_gpt
insmod ext2
set root=(hd0,3)

if loadfont /boot/grub/fonts/unicode.pf2; then
  set gfxmode=auto
  insmod all_video
  terminal_output gfxterm
fi

menuentry "Arch/Linux, 5.18.14-xanmod1" {
        linux   /boot/vmlinuz-5.18.14-xanmod1 root=/dev/sda3 rw nvidia-drm.modeset=1 quiet
}

menuentry "BLFS/Linux, 5.18.14-xanmod1" {
        linux   /boot/vmlinuz-5.18.14-xanmod1 root=/dev/sda3 rw  loglevel=3 quiet
}

menuentry "BLFS/Linux, 5.17.5-xanmod1-systemd" {
set root=(hd1,4)
        linux   /boot/vmlinuz-5.18.3-xanmod1 root=/dev/sdb4 ro
}

menuentry "Windows 10" {
  insmod fat
  insmod chain
  set root=(hd0,1)
  chainloader /EFI/Microsoft/Boot/bootmgfw.efi
}
EOF
```



## 附软件包清单
### 基础系统组件：
`base base base-devel openssh nano xorg-server xorg-xinit`
### X环境组件及Terminal
`xorg-server xorg-xinit alacritty`
### 字体
`ttf-ubuntu-font-family noto-fonts-emoji wqy-microhei`
### GRUB UEFI引导
`grub efibootmgr`
### Plasma5桌面(精简安装)
```
plasma-desktop plasma-wayland-session systemsettings plasma-systemmonitor powerdevil bluedevil plasma-nm plasma-pa dolphin kwrite
```
### 蓝牙音频支持
`pulseaudio-bluetooth pulseaudio-alsa bluez-utils`
### 音视频播放
`mpv lx-music-bin（AUR包，yay安装）`
### 压缩包管理器
`ark`
### 输入法
`fcitx5-rime fcitx5-gtk fcitx5-qt`
### 桌面Dock菜单
`latte-Dock`
### 浏览器
`firefox`
### 屏幕录制(X11)
`simplescreenrecorder`
### DW1560、Nividia特殊硬件驱动
`broadcom-wl-dkms bcm20702a1-firmware nvidia-dkms`
### 进阶开发相关
`base-devel bc openssh clang git`
### 安装AUR管理器
```
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```
`yay -h 查看yay使用说明    如，yay lx-music-bin bcm20702a1-firmware`
