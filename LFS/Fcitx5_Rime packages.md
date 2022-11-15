## How to build Fcitx5 and Rime on LFS / Blfs  
Build Internal package following LFS / BLFS Book,  Extenal package following it's technology document.  
### Fcitx5 Dependencies:
    C Compiler
    C++ Compiler
    CMake
    ECM (Extra CMake Modules)
    GNU Make
    XCB (X protocol C-language Binding)
    Expat
    PkgConfig
    json-c
    dbus
    fmt
    enchant
    cldr-emoji-annotation*
    gettext (for build fcitx5-rime)*

### Rime Dependencies:
```
Building:
    compiler with C++14 support
    cmake>=2.8
    libboost>=1.48
    libleveldb
    libmarisa
    libopencc>=1.0.2
    libyaml-cpp>=0.5
    libglog (optional)
    libgtest (optional)
  Runtime:
    libboost
    libleveldb
    libmarisa
    libopencc
    libyaml-cpp
    libglog (optional)
```

## Build Fcitx5 Following LFS / BLFS:
##### Internal:
	gcc (LFS Book package)
	make (LFS Book package)
	PkgConfig (LFS Book package)
	cmake
	extra-cmake-modules
	xcb-util
	xcb-util-proto
	xcb-util-renderutil
	xcb-util-image
	xcb-util-keysyms
	xcb-util-wm
	dbus
	XKeyboardConfig
	json-c
	iso codes
	aspell (with at list one dictionaries)
	gtk+2
	gtk+3
	enchant
	qt5 (optional, if build fcitx5-qt or fcitx5-configtool)
##### Extenal:
	expat
```
git clone --depth=1 https://github.com/libexpat/libexpat.git
cd libexpat/expat (sources file in expat dir)
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DEXPAT_BUILD_EXAMPLES=OFF -DEXPAT_BUILD_TESTS=OFF -DEXPAT_SHARED_LIBS=ON -DEXPAT_BUILD_DOCS=OFF -DEXPAT_BUILD_PKGCONFIG=ON -DEXPAT_BUILD_TESTS=OFF ..
( or ../configure --prefix=/usr --disable-static --disable-test)
make
make install
```
	fmt
```
git clone --depth=1 https://github.com/fmtlib/fmt.git
cd fmt && mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=ON -DFMT_TEST=OFF -DFMT_DEBUG_POSTFIX=OFF -DFMT_DOC=FALSE -DFMT_CUDA_TEST=OFF ..
make
make install
```
	xcb-imdkit
```
git clone --depth=1 https://github.com/fcitx/xcb-imdkit.git
cd xcb-imdkit && mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=TRUE ..
make
make install
```
	cldr-emoji-annotation (optional, if need emoji fonts support)
```
git clone --depth=1 https://github.com/fujiwarat/cldr-emoji-annotation.git
cd cldr-emoji-annotation && mkdir m4
autoreconf -i
mkdir build && cd build
../configure --prefix=/usr --enable-dtd --disable-maintainer-mode --enable-shared --disable-static
make
make install
```
	fcitx5
```
git clone --depth=1 https://github.com/fcitx/fcitx5.git
cd fcitx5 && mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DENABLE_WAYLAND=ON -DENABLE_TEST=OFF -DENABLE_EMOJI=ON -DENABLE_ENCHANT=ON -DENABLE_X11=ON -DUSE_SYSTEMD=OFF -DDBUS=OFF -DENABLE_DOC=OFF ..
make
make install
```
	fcitx5-gtk
```
git clone --depth=1 https://github.com/fcitx/fcitx5-gtk.git
cd fcitx5-gtk && mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=TRUE -DCMAKE_BUILD_TYPE=Release -DENABLE_GTK2_IM_MODULE=OFF -DENABLE_GTK3_IM_MODULE=ON -DENABLE_GTK4_IM_MODULE=OFF ..
(SET GTK2 GTK3 GTK4 MODULE FOR YOURSELF)
make
make install
```
	fcitx5-qt
	fcitx5-configtool
##### Others:
   	following Dependencies required for other fcitx5 modules

## Build Rime Following LFS / BLFS:
##### Internal:
  	gcc
  	cmake
  	boost
##### External:
   	leveldb
```
git clone --depth=1 https://github.com/google/leveldb.git
cd leveldb && mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=ON -DLEVELDB_BUILD_BENCHMARKS=OFF -DLEVELDB_BUILD_TESTS=OFF ..
make
make install
```
   	marisa
```
git clone --depth=1 https://github.com/s-yata/marisa-trie.git
cd marisa-trie
autoreconf -i
./configure --prefix=/usr --enable-native-code --enable-shared --disable-static --enable-native-code
make
make install
```
   	opencc
```
git clone --depth=1 https://github.com/BYVoid/OpenCC.git
cd OpenCC && mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_DOCUMENTATION=OFF -DENABLE_BENCHMARK=OFF -DENABLE_GTEST=OFF -DUSE_SYSTEM_GOOGLE_BENCHMARK=OFF -DUSE_SYSTEM_GTEST=OFF ..
make
make install
```
   	yaml-cpp
```
git clone --depth=1 https://github.com/jbeder/yaml-cpp.git
cd yaml-cpp && mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DYAML_BUILD_SHARED_LIBS=ON -DYAML_CPP_BUILD_TOOLS=OFF -DYAML_CPP_BUILD_TESTS=OFF ..
make
make install
```
   	capnproto
```
git clone --depth=1 https://github.com/capnproto/capnproto.git
cd capnproto && mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=ON  ..
make
make install
```
   	librime
```
git clone --depth=1 https://github.com/rime/librime.git
cd librime && mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DRIME_DATA_DIR=/etc/rime-data -DBOOST_USE_CXX11=ON -DBUILD_TEST=OFF -DENABLE_LOGGING=OFF -DCMAKE_DISABLE_FIND_PACKAGE_Gflags=ON -DENABLE_ASAN=ON -DENABLE_EXTERNAL_PLUGINS=ON -DINSTALL_PRIVATE_HEADERS=ON ..
make
make install
```
   	fcitx5-rime
```
git clone --depth=1 https://github.com/fcitx/fcitx5-rime.git
cd fcitx5-rime && mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=TRUE -DRIME_DATA_DIR=/etc/rime ..
make
make install
```
   	rime-data
```
將rime-data文件複製到/etc/rime目錄內即可
```
