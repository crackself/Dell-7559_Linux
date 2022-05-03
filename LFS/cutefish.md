## BLFS安装cutefishOS桌面
### 安装KF5依赖
##### 精简安装KF5组件
```
5d9784ee2bd02ca0764c6bd1d8589dff  attica-5.91.0.tar.xz
c1bd7b16fd4b488f38d008574871e7a6  karchive-5.91.0.tar.xz
643759d7e8b7edafcd96fe57a31f65ba  kcodecs-5.91.0.tar.xz
503fb86945377cc4e6824526083a03c2  kconfig-5.91.0.tar.xz
4d39a971050164eca9cfd17267fbd49d  kcoreaddons-5.91.0.tar.xz
df8c55668581077a980ac34b97533a6a  kdbusaddons-5.91.0.tar.xz
d35d659076a7e693f534b075e977938c  kguiaddons-5.91.0.tar.xz
8def96f2eecd9351350f749344bfb6e7  ki18n-5.91.0.tar.xz
0277a06b454a12cb9081238acc20d9ff  kidletime-5.91.0.tar.xz
7fccfc2d2f03620933623e2a92fb31d5  kitemviews-5.91.0.tar.xz
53ef80abdb614eb4b3db80299a648303  kwidgetsaddons-5.91.0.tar.xz
3741a8dd1af123a48f8f622c5000457f  kwindowsystem-5.91.0.tar.xz
022818490366c1c84b099855135882b3  networkmanager-qt-5.91.0.tar.xz
59f5148ddc67455188c81d570167147f  solid-5.91.0.tar.xz
ca8498069ae692512a7a884492898db9  sonnet-5.91.0.tar.xz
9771c45d5646210509a1f336f080db8a  kauth-5.91.0.tar.xz
e4ad9f872cddaa3deef16fcc202e8b53  kcompletion-5.91.0.tar.xz
f8444d0caacd92799fc9d869331899bb  kcrash-5.91.0.tar.xz
c29c3835fc89c0004c5d9586efdca8ee  kconfigwidgets-5.91.0.tar.xz
b45f86503ff166a69a7cd2fc2f3fdca2  kservice-5.91.0.tar.xz
da8b36e6c834f7181983fba73828ee42  kglobalaccel-5.91.0.tar.xz
6e72bd9c68eba7a05c735e4b17238ec9  kpackage-5.91.0.tar.xz
49df446c1150b92021c42e1d0ca70cc2  kiconthemes-5.91.0.tar.xz
eca731f12d135cc92d53cc95f9598d24  kjobwidgets-5.91.0.tar.xz
392da2d1e13bdfbbe9f799f8b6ffd216  knotifications-5.91.0.tar.xz
f67fa515f50c11fcb376d26f2197a4d8  ktextwidgets-5.91.0.tar.xz
6331ab56636c38cf9ca59ac3f43e4aa3  kxmlgui-5.91.0.tar.xz
4d76d18f66b841a5198d9e5449478bba  kbookmarks-5.91.0.tar.xz
b1ce633d68b986a917cf81132927e574  kio-5.91.0.tar.xz
bd47095a50a31c273f48e5b0a0178f02  kdeclarative-5.91.0.tar.xz
393d52ba4883d61dd9b1f06df04b2f27  kcmutils-5.91.0.tar.xz
c0c4e2f09fea4440da5c1777cc3605b3  kirigami2-5.91.0.tar.xz
140700c804ef89f06024524c8a51daa5  knewstuff-5.91.0.tar.xz
9f80142ffe37b515b34dc0889126fe65  kactivities-5.91.0.tar.xz
ceb9a445c9c074cd922c929454dfcf05  kwayland-5.91.0.tar.xz
0e8698ea83e84bfc6709f378a32b6ba3  plasma-framework-5.91.0.tar.xz
996e0521066cf5c5cf73a23b5d24acc6  modemmanager-qt-5.91.0.tar.xz
6603e4e589a0701526b620f6cbb76b49  bluez-qt-5.91.0.tar.xz
```

##### 精简安装Plasma5组件
```
d5a143b93d183e46d2d9eecb65ca32d6  kdecoration-5.24.4.tar.xz
25328009546df7703a45a51c27befc76  libkscreen-5.24.4.tar.xz
127f90c5e77d404949446813baf7d61a  kscreenlocker-5.24.4.tar.xz
7eae43606459dd0a288d5c081d9a6a2a  layer-shell-qt-5.24.4.tar.xz
cad3dc7c0b9ca2faa9f8d25b4b2d857d  kwayland-server-5.24.4.tar.xz
a401b80ab133740bb9c006cdf0eaedbf  kwin-5.24.4.tar.xz
```
#### 安装其它额外组件
##### [lxqt-build-tools](https://github.com/lxqt/lxqt-build-tools)
```
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr ..  && make && make install
```
##### [libqtxdg](https://github.com/lxqt/libqtxdg)
```
libqtxdg-3.8.0/src/qtxdg/xdgmimeappsglibbackend.cpp
		#include <gio/gdesktopappinfo.h> 改为以下
		#include </usr/include/gio-unix-2.0/gio/gdesktopappinfo.h>
		
libqtxdg-3.8.0/CMakeLists.txt
		find_package(GLIB ${GLIB_MINIMUM_VERSION} REQUIRED COMPONENTS gobject gio gio-unix 改为以下)
		find_package(GLIB ${GLIB_MINIMUM_VERSION} REQUIRED COMPONENTS gobject gio gio-unix-2.0))
```
#### 安装cutefish组件
#### 
```
cutefish_core移除synaptics
删除synaptics相关代码，取消synaptics系统依赖
	修改：     settings-daemon/CMakeLists.txt
	删除：     settings-daemon/touchpad/x11/synapticstouchpad.cpp
	删除：     settings-daemon/touchpad/x11/synapticstouchpad.h
	修改：     settings-daemon/touchpad/x11/xlibbackend.cpp
	修改：     settings-daemon/touchpad/x11/xlibbackend.h
```
```

```
