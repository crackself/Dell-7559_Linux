### 截图工具：[flameshot 火焰截图](https://github.com/flameshot-org/flameshot#packages-from-repository)
    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_STATIC_LIBS=OFF -DBUILD_SHARED_LIBS=ON ..
    make 
    make install

### 系统监测工具 [xfce4-taskmanager](https://docs.xfce.org/apps/xfce4-taskmanager/start)
    mkdir build
    cd build
    ../configure --prefix=/usr --disable-static --enable-shared --disable-debug --with-x
    make 
    make install

### Libreoffice
不需安装postgresql openldap
```
./autogen.sh --prefix=$LO_PREFIX         \
             --with-parallelism=4           \
             --sysconfdir=/etc           \
             --with-vendor=BLFS          \
             --with-lang='zh-CN'      \
             --with-help                 \
             --with-myspell-dicts        \
             --without-junit             \
             --without-system-dicts      \
             --disable-dconf             \
             --disable-odk               \
             --without-fonts             \
             --without-java              \
             --enable-release-build=yes  \
             --enable-python=system      \
             --with-jdk-home=/opt/jdk    \
             --with-system-apr           \
             --with-system-boost         \
             --with-system-clucene       \
             --with-system-curl          \
             --with-system-epoxy         \
             --with-system-expat         \
             --with-system-glm           \
             --with-system-gpgmepp       \
             --with-system-graphite      \
             --with-system-harfbuzz      \
             --with-system-icu           \
             --with-system-jpeg          \
             --with-system-lcms2         \
             --with-system-libatomic_ops \
             --with-system-libpng        \
             --with-system-libxml        \
             --with-system-neon          \
             --with-system-nss           \
             --with-system-odbc          \
             --with-system-openldap      \
             --with-system-openssl       \
             --with-system-poppler       \
             --with-system-redland       \
             --with-system-serf          \
             --with-system-zlib          \
             --disable-firebird-sdbc     \
             --disable-postgresql-sdbc   \
             --disable-skia              \
             --disable-ldap              \
             --enable-lto
```

### Xorg
`$XORG_PREFIX="/usr"`
#### xorg-app
##### installed
```
5d3feaa898875484b6b340b3888d49d8  iceauth-1.0.9.tar.xz
92be564d4be7d8aa7b5024057b715210  sessreg-1.1.2.tar.bz2
3a93d9f0859de5d8b65a68a125d48f6a  smproxy-1.0.6.tar.bz2
dbcf944eb59343b84799b2cc70aace16  xauth-1.1.2.tar.xz
5b6405973db69c0443be2fba8e1a8ab7  xbacklight-1.2.3.tar.bz2
f67116760888f2e06486ee3d179875d2  xdpyinfo-1.3.3.tar.xz
480e63cd365f03eb2515a6527d5f4ca6  xdriinfo-1.0.6.tar.bz2
c45e9f7971a58b8f0faf10f6d8f298c0  xkbcomp-1.4.5.tar.bz2
0d66e07595ea083871048c4b805d8b13  xmodmap-1.0.11.tar.xz
2358e29133d183ff67d4ef8afd70b9d2  xprop-1.2.5.tar.bz2
85f04a810e2fb6b41ab872b421dce1b1  xrdb-1.2.1.tar.bz2
33b04489e417d73c90295bd2a0781cbb  xrefresh-1.0.7.tar.xz
b13afec137b9b331814a9824ab03ec80  xvinfo-1.1.4.tar.bz2
26d46f7ef0588d3392da3ad5802be420  xwininfo-1.1.5.tar.bz2
```
##### mini_installed
```
5d3feaa898875484b6b340b3888d49d8  iceauth-1.0.9.tar.xz
dbcf944eb59343b84799b2cc70aace16  xauth-1.1.2.tar.xz
5b6405973db69c0443be2fba8e1a8ab7  xbacklight-1.2.3.tar.bz2
c45e9f7971a58b8f0faf10f6d8f298c0  xkbcomp-1.4.5.tar.bz2
85f04a810e2fb6b41ab872b421dce1b1  xrdb-1.2.1.tar.bz2
```
### xorg-lib full installed

### LLVM
```
CC=gcc CXX=g++                                  \
cmake -DCMAKE_INSTALL_PREFIX=/usr               \
      -DLLVM_ENABLE_FFI=ON                      \
      -DCMAKE_BUILD_TYPE=Release                \
      -DLLVM_BUILD_LLVM_DYLIB=ON                \
      -DLLVM_LINK_LLVM_DYLIB=ON                 \
      -DLLVM_ENABLE_RTTI=ON                     \
      -DLLVM_TARGETS_TO_BUILD="host;X86;BPF" \
      -DLLVM_BINUTILS_INCDIR=/usr/include       \
      -DLLVM_INCLUDE_BENCHMARKS=OFF             \
      -Wno-dev -G Ninja ..                      &&
ninja

```
#### mesa
```
patch -Np1 -i ../mesa-21.3.7-add_xdemos-1.patch
GALLIUM_DRV="crocus,i915,iris,swrast,virgl"
DRI_DRIVERS="i965"
PLATFORM="x11,wayland"
patch -Np1 -i ../mesa-21.3.7-nouveau_fixes-1.patch
mkdir build
cd    build

meson --prefix=$XORG_PREFIX          \
      --buildtype=release            \
      -Ddri-drivers=$DRI_DRIVERS     \
      -Dgallium-drivers=$GALLIUM_DRV \
      -Dgallium-nine=false           \
      -Dglx=dri                      \
      -Dvalgrind=disabled            \
      -Dlibunwind=disabled           \
      -Dvulkan-drivers=intel         \
      -Dplatforms=$PLATFORM          \
      -Dgles2=enabled                \
      ..

unset GALLIUM_DRV DRI_DRIVERS PLATFORM

ninja
ninja install
```
or
```
meson --prefix=$XORG_PREFIX   \
      --buildtype=release     \
      -Dplatforms=x11,wayland \
      -Dgallium-drivers="iris"  \
      -Dglx=dri               \
      -Dvalgrind=disabled     \
      -Dlibunwind=disabled    \
      -Dvulkan-drivers=intel \
      -Dgles2=enabled         \
      ..                      &&

ninja
```

### MPV player
#### required `lua-5.2` `mujs`
#### recommonded `libblueray` 
#### build [mujs](https://github.com/ccxvii/mujs/)
`make CFLANGS+="-fPIC" prefix=/usr libdir=/usr/lib install-shared`
#### build [libblueray](https://www.videolan.org/developers/libbluray.html)
`./configure --prefix=/usr --disable-static --enable-shared --disable-tests --disable-examples --disable-bdjava-jar`

#### mpv-options
```
--prefix=/usr
--enable-lua
--enable-javascript
--enable-libmpv-shared
--disable-libmpv-static
--disable-static-build
--enable-optimize
--disable-debug-build
--disable-tests
--disable-ta-leak-report
--disable-manpage-build
--disable-html-build
```
#### QT5
```
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
            -gui                                      \
            -release                                  \
            -xcb-xlib                                 \
            -cups                                     \
            -no-gstreamer                             \
            -skip qtwebengine
```
### [mobile-broadband-provider-info](https://download.gnome.org/sources/mobile-broadband-provider-info/)
```
./configure --prefix=/usr
make install
```

### To Do
Blender
是一款免费开源三维图形图像软件，提供从建模、动画、材质、渲染、到音频处理、视频剪辑等一系列动画短片制作解决方案 YT上很多大佬都在使用 游戏建模 动画制作非常推荐这款
https://www.blender.org/

ONLYOFFICE
ONLYOFFICE是 Windows、macOS 和 Linux 的下的开源办公套件
https://www.onlyoffice.com/zh/download-desktop.aspx

Ardour
音频编辑器
https://ardour.org/

kdenlive
自由开源的免费视频编辑软件。简单易学，永久免费，用途不限
https://kdenlive.org/zh/

Inkscape
矢量图编辑器 这款软件应该不需要多介绍了吧 常被引用为开源软件强大程度的一个例子
https://inkscape.org/

krita
开源的绘画软件
https://krita.org/zh/

OBS Studio
Open Broadcaster Software 是一款好用的互联网流媒体直播内容输入作软件
https://obsproject.com/zh-cn/download
