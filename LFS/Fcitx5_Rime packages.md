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
    cldr-emoji-annotation*

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
	qt5 (optional, if build fcitx5-qt or fcitx5-configtool)
##### Extenal:
	expat
	fmt
	xcb-imdkit
	cldr-emoji-annotation (optional, if need emoji fonts support)
	fcitx5
	fcitx5-gtk
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
   	marisa
   	opencc
   	yaml-cpp
   	capnproto
   	librime
   	rime-data
   	fcitx5-rime
   	
