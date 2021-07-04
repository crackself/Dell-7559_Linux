### 安装前准备 (Gentoo linux)
```
eselect profile set 1
  [1]   default/linux/amd64/17.1 (stable) *
```
### 图形显示组件
    x11-apps：
    xrandr
    xorg-server
    xinit
    x11-apps/xbacklight     # replace xbacklight
    dwm
    dmenu
    slstatus (手动编译安装)
    x11-drivers/nvidia-drivers

### 应用组件
    kde-apps：
    dolphin	# filemanager
    kwrite	# txt editor
    scrot   # screenshot
    feh     # set desktop wall paper
    mpv
    alacritty
    picom
    kwrite
    wps-office
    www-cilent/firefox
    media-gfx/gimp

### 输入法
    app-i18n/fcitx
    app-i18n/fcitx-gtk
    app-i18n/fcitx-qt5
    app-i18n/fcitx-configtool
    app-i18n/fcitx-rime

### 依赖字体
    media-fonts：
    fontawesome
    noto-cjk
    noto-emoji  # 可选
 
### 网络管理组件
    dhcpcd
    networkmanerge(KDE桌面建议)

#### 暂时关闭emerge的文件校验功能以修改dwm源码安装
    nano /etc/portage/make.conf
    FEATURES="-strict -assume-digests -sign"

    nano /var/db/repos/gentoo/metadata/layout.conf
    use-manifests = false

### 可选功能
#### KDE桌面组件
    kde-plasma：
    plasma-destop
    plasma-nm
    plasma-pa
    powerdevil
    bluedevil
    plasma-systemmonitor
    systemsettings
    
    app-i18n/kcm-fcitx
##### 安装网易云音乐
    依赖：net-print/cups
    https://github.com/Rocket1184/electron-netease-cloud-music/
    下载二进制文件后 tar xf filename.tar.gz
    将解压后文件夹命名为electron-netease-cloud-music
    参考Archlinux PKGmakefile 「https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=electron-netease-cloud-music」
    将文件复制到对应位置
    cp -r electron-netease-cloud-music /usr/lib/
    cat > /usr/share/applications/electron-netease-cloud-music.desktop << EOF
    [Desktop Entry]
    Type=Application
    Name=ElectronNCM
    Name[zh_CN]=ElectronNCM
    Name[zh_TW]=ElectronNCM
    Comment=UNOFFICIAL client for music.163.com
    Comment[zh_CN]=网易云音乐非官方客户端
    Comment[zh_TW]=網易雲音樂非官方用戶端
    Icon=electron-netease-cloud-music
    Exec=/usr/local/bin/electron-netease-cloud-music/electron-netease-cloud-music
    Categories=AudioVideo;Player;
    EOF

    cat > /usr/local/bin/electron-netease-cloud-music << EOF
    #!/bin/bash
    exec /usr/lib/electron-netease-cloud-music/electron-netease-cloud-music
    EOF

chmod +x /usr/local/bin/electron-netease-cloud-music

cd /usr/share/icons/hicolor/scalable/apps/
sudo wget https://raw.githubusercontent.com/Rocket1184/electron-netease-cloud-music/master/assets/icons/icon.svg
sudo mv icon.svg electron-netease-cloud-music.svg

## 预览
![avatar](https://github.com/crackself/Dell-7559_Linux/raw/master/dwm/image/2021-07-04-111335_1920x1080_scrot.png)
![avatar](https://github.com/crackself/Dell-7559_Linux/raw/master/dwm/image/2021-07-04-111413_1920x1080_scrot.png)
