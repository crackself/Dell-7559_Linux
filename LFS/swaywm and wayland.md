## 组件说明
- swaywwm(sway) 窗口管理器
- waybar  状态栏显示组件
- wofi    程序菜单
### [swaywm](https://github.com/swaywm/sway.git)依赖（需安装mesa及对应的显卡驱动）
```
meson               LFS 已安装
wlroots
wayland             BLFS安装
wayland-protocols   BLFS安装
pcre2               BLFS安装
json-c              BLFS安装
pango               BLFS安装
cairo               BLFS安装
gdk-pixbuf2 (optional: system tray)   BLFS安装
scdoc (optional: man pages) * 
git (optional: version info) *        BLFS安装
```
### 额外需要安装的BLFS组件
- 依据sway或其组件编译提示安装对应依赖
```
mesa（及相应显卡驱动）
elogind
dbus
gtkmm3
libinput
```
- 其中`wlroots`、`scdoc`不在LFS/BLFS中，需自行编译安装

### 安装swaywm依赖及组件
### [hwdata](https://github.com/vcrhonek/hwdata)
```
git clone --depth=1 https://github.com/vcrhonek/hwdata.git
cd hwdata && mkdir build && cd build
./configure --prefix=/usr
make
make install
```
### [seatd](https://git.sr.ht/~kennylevinsen/seatd)
```
git clone --depth=1 https://git.sr.ht/~kennylevinsen/seatd
cd seatd && mkdir build && cd build
meson --prefix=/usr -Dman-pages=disabled -Dlibseat-logind=elogind -Dlibseat-builtin=enabled -Dserver=enabled ..
ninja
ninja insttall
```

#### [wlroots](https://gitlab.freedesktop.org/wlroots/wlroots.git)
```
git clone --depth=1 https://gitlab.freedesktop.org/wlroots/wlroots.git
cd wlroot && mkdir build && cd build
meson --prefix=/usr -Dexamples=false -Dbackends=drm,libinput -Dxcb-errors=disabled ..
ninja
ninja install
```

### [swaywm](https://github.com/swaywm/sway.git)
```
git clone --depth=1 https://github.com/swaywm/sway.git
cd sway && mkdir build && cd build
meson --prefix=/usr -Dman-pages=disabled ..
ninja
```

### [waybar](https://github.com/Alexays/Waybar.git)
```
git clone --depth=1 https://github.com/Alexays/Waybar.git
cd waybar && mkdir build && cd build
meson --prefix=/usr -Dman-pages=disabled -Dtests=disabled ..
ninja
ninja install
```

### [wofi](https://github.com/kohnish/wofi.git)
```
git clone --depth=1 https://github.com/kohnish/wofi.git
cd wofi && mkdir build && cd build
meson --prefix=/usr ..
ninja
ninja install
```
