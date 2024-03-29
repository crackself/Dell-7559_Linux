## BLFS系统下编译fcitx5、librime
#### 所需依赖参考[Fcitx5官方编译说明](https://fcitx-im.org/wiki/Compiling_fcitx5)
#### 确保已设置X环境或系统locale为非C.posx 否则部分程序无法使用 [官方说明](https://fcitx-im.org/wiki/FAQ)
    确保安装系统中文locale：
    localedef -i zh_CN -f UTF-8 zh_CN.UTF-8

    nano ~/.xinitrc
    export LANG="zh_CN.UTF-8"
    export LANGUAGE="zh_CN:en_US"
    
    nano /etc/profile.d/i18n.sh
    # Set up i18n variables
    #. /etc/locale.conf
    #export LANG=zh_CN.UTF-8
    export XMODIFIERS=@im=fcitx
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    
#### 以下依赖包参照BLFS官方文档编译，安装位置为`/usr`
    xcb-util
    xcb-util-proto
    xcb-util-renderutil
    xcb-util-image
    xcb-util-keysyms
    xcb-util-wm
    enchant
    cmake
    extra-cmake-modules
    boost
    json-c
    ISO Codes
    dbus
    ECM (Extra CMake Modules)
    gcc
    gtk+2
    gtk+3
    XKeyboardConfig
    aspell (and dictionaries)
    以下为非必须
    qt5（fcitx5-qt、fcitx5-configtool需QT组件）

#### 以下依赖包参照各自文档及Gentoo安装包编译，安装位置为`/usr/local`
    capnproto       # 安装后需reboot系统以确保生效
    glog
    leveldb
    marisa
    opencc
    yaml-cpp
    expat
    fmt
    xcb-imdkit
    librime
    fcitx5
    fcitx5-gtk
    rime-data
    fcitx5-rime

####  capnproto
    curl -O https://capnproto.org/capnproto-c++-0.9.1.tar.gz
    tar zxf capnproto-c++-0.9.1.tar.gz
    mkdir build && cd build	
    ../configure --prefix=/usr --disable-static --enable-shared
    make
    make install
    
    or
    
    git clone --depth=1 https://github.com/capnproto/capnproto.git
    mkdir build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=ON  ..
    make
    makeinstall
    
####  glog (optional)
    https://github.com/google/glog.git
    mkdir build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_TESTING=OFF -DWITH_CUSTOM_PREFIX=ON -DWITH_GFLAGS=ON -DWITH_GTEST=OFF -DWITH_UNWIND=ON ..
    make
    make install

####  leveldb
    git clone --depth=1 https://github.com/google/leveldb.git
    mkdir build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=ON -DLEVELDB_BUILD_BENCHMARKS=OFF -DLEVELDB_BUILD_TESTS=OFF ..
    make
    make install

####  marisa-trie
    git clone --depth=1 https://github.com/s-yata/marisa-trie.git
    autoreconf -i
    ./configure --prefix=/usr --enable-native-code --enable-shared --disable-static --disable-test
    make
    make install

#### opencc
    git clone --depth=1 https://github.com/BYVoid/OpenCC.git
    mkdir build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_DOCUMENTATION=OFF -DENABLE_BENCHMARK=OFF -DENABLE_GTEST=OFF -DUSE_SYSTEM_GOOGLE_BENCHMARK=OFF -DUSE_SYSTEM_GTEST=OFF ..
    make
    make install

#### yaml-cpp
    git clone --depth=1 https://github.com/jbeder/yaml-cpp.git
    mkdir build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DYAML_BUILD_SHARED_LIBS=ON -DYAML_CPP_BUILD_TOOLS=OFF -DYAML_CPP_BUILD_TESTS=OFF ..
    make
    make install

#### expat
    git clone --depth=1 https://github.com/libexpat/libexpat.git
    sources file in expat dir
    mkdir build && cd build
    (../configure --prefix=/usr --disable-static --disable-test)
    or
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DEXPAT_BUILD_EXAMPLES=OFF -DEXPAT_BUILD_TESTS=OFF -DEXPAT_SHARED_LIBS=ON -DEXPAT_BUILD_DOCS=OFF -DEXPAT_BUILD_PKGCONFIG=ON ..
    make
    make install

#### fmt
    https://fmt.dev/latest/index.html
    git clone --depth=1 https://github.com/fmtlib/fmt.git
    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=TRUE -DFMT_TEST=FALSE ..
    make
    make install

#### xcb-imdkit
    git clone --depth=1 https://github.com/fcitx/xcb-imdkit.git
    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=TRUE ..
    make
    make install

### cldr-emoji-annotation
    git clone --depth=1 https://github.com/fujiwarat/cldr-emoji-annotation.git
    mkdir m4
    autoreconf -i
    mkdir build && cd build
    ../configure --prefix=/usr
    make
    make install
    
#### librime
    git clone --depth=1 https://github.com/rime/librime.git
    mkdir build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DBOOST_USE_CXX11=ON -DBUILD_TEST=OFF -DENABLE_LOGGING=OFF -DCMAKE_DISABLE_FIND_PACKAGE_Gflags=ON -DENABLE_EXTERNAL_PLUGINS=ON -DINSTALL_PRIVATE_HEADERS=ON ..
    make
    make install

#### fcitx5
    git clone --depth=1 https://github.com/fcitx/fcitx5.git
    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DENABLE_WAYLAND=ON -DENABLE_TEST=OFF -DENABLE_EMOJI=ON -DENABLE_ENCHANT=ON -DENABLE_X11=ON -DUSE_SYSTEMD=OFF -DDBUS=OFF ..
    make
    make install

#### fcitx5-gtk
    git clone --depth=1 https://github.com/fcitx/fcitx5-gtk.git
    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=TRUE -DCMAKE_BUILD_TYPE=Release -DENABLE_GTK2_IM_MODULE=ON -DENABLE_GTK3_IM_MODULE=ON -DENABLE_GTK4_IM_MODULE=OFF ..
    make
    make install

#### fcitx5-qt
    git clone --depth=1 https://github.com/fcitx/fcitx5-qt.git
    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=TRUE -DCMAKE_BUILD_TYPE=Release -DENABLE_QT4=no -DENABLE_QT5=qt5 ..
    (cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=TRUE -DCMAKE_BUILD_TYPE=Release -DENABLE_QT4=no -DENABLE_QT5=qt5 -DBUILD_ONLY_PLUGIN=ON ..)
    make
    make install

#### rime-data
    # just copy rime-data into /etc/rime

#### fcitx5-rime
    git clone --depth=1 https://github.com/fcitx/fcitx5-rime.git
    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=TRUE -DRIME_DATA_DIR=/etc/rime ..
    make
    make install

### Fcitx5 配置文件、主题美化
#### Fcitx5-Rime输入法配置（非必须，若fcitx5在fcitx5-rime安装之前已启动，则需手动修改此配置文件，或删之后重启fcitx5）
`nano ~/.config/fcitx5/profile`
```
[Groups/0]
# Group Name
Name=Default
# Layout
Default Layout=us
# Default Input Method
DefaultIM=rime

[Groups/0/Items/0]
# Name
Name=keyboard-us
# Layout
Layout=

[Groups/0/Items/1]
# Name
Name=rime
# Layout
Layout=

[GroupOrder]
0=Default
```

#### Fcitx5 皮肤设置
`nano ~/.config/fcitx5/conf/classicui.conf`

    # 垂直候选列表
    Vertical Candidate List=False

    # 按屏幕 DPI 使用
    PerScreenDPI=True

    # Font (设置成你喜欢的字体)
    #Font="思源黑体 CN Medium 15"
    Font="Ubuntu Mono 15"

    # 主题
    Theme=Material-Color

#### Fcitx5主题文件
[ Fcitx5-Material-Color](https://github.com/hosxy/Fcitx5-Material-Color.git)

#### 安装主题文件
    mkdir -p ~/.local/share/fcitx5/themes/Material-Color
    git clone https://github.com/hosxy/Fcitx5-Material-Color.git ~/.local/share/fcitx5/themes/Material-Color

#### 手动设置配色方案
    cd ~/.local/share/fcitx5/themes/Material-Color
    ln -sf ./theme-deepPurple.conf theme.conf
