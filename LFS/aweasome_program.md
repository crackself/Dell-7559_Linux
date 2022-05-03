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
### MPV player
#### required `lua-5.2` `mujs`
#### recommonded `libblueray` 
#### build mujs
`ake CFLANGS+="-fPIC" prefix=/usr libdir=/usr/lib install-shared`
#### build libblueray
`./configure --prefix=/usr --enable-shared --disable-tests --disable-bdjava-jar`

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
            -gui                                   \
            -release                                    \
            -xcb-xlib                                    \
            -cups                                    \
            -skip qtwebengine
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
