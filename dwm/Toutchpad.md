### 通过[libinput](https://wiki.archlinux.org/title/Libinput)驱动Elan触控板
`I2C/USB设备，需要开启内核I2C/USB、HID设备支持，文末以配置内核I2C、HID为例。`

### 安装：

    pacman -S libinput xf86-input-libinput
#### 配置文件：
    nano /etc/X11/xorg.conf.d/30-touchpad.conf
```
Section "InputClass"
        # 设备名称
        Identifier "ETPS/2 Elantech Touchpad"
        MatchIsTouchpad "on"
        # 设备路径
        MatchDevicePath "/dev/input/event10"
        Driver "libinput"
        #
        # 开/关设备功能
        Option "Tapping" "on"
        #Option "ScrollMethod" "edge"
        Option "ScrollMethod" "twofinger"
        Option "NaturalScrolling" "true"
        Option "MiddleEmulation" "true"
        Option "LeftHanded" "false"
        #Option "ClickMethod" "clickfinger"
        Option "ClickMethod" "buttonareas"
        Option "DisableWhileTyping" "true"
        #Enables or disables tap-to-click behavior
        Option "Tapping" "true"
        #Enables or disables drag during tapping behavior
        Option "TappingDrag" "true"
        #Enables or disables drag lock during tapping behavior
        Option "TappingDragLock" "true"
        #Setting acceleration to 90%
        Option "TransformationMatrix" "0.90 0 0 0 0.90 0 0 0 1"
        #Disabling acceleration on touchpad
        #Option "AccelProfile" "flat"
EndSection
```
### 查看所有libinput支持的设备及其具有的功能：

    sudo libinput list-devices

```
    ...
    Device:           ETPS/2 Elantech Touchpad
    Kernel:           /dev/input/event10
    Group:            8
    Seat:             seat0, default
    Size:             104x78mm
    Capabilities:     pointer gesture
    Tap-to-click:     disabled
    Tap-and-drag:     enabled
    Tap drag lock:    disabled
    Left-handed:      disabled
    Nat.scrolling:    disabled
    Middle emulation: disabled
    Calibration:      n/a
    Scroll methods:   *two-finger edge
    Click methods:    *button-areas clickfinger
    Disable-w-typing: enabled
    Accel profiles:   flat *adaptive
    Rotation:         n/a
    ...
```
### 内核驱动模块开启
```
Device Drivers  --->
    Input device support  --->
        Mice  --->
            ...
            <*>   PS/2 mouse
            ...
            <*>   Mouse interface
            [*]   Provide legacy /dev/psaux device
            ...
            <*>   ELAN I2C Touchpad support
            [*]     Enable I2C support
            [*]     Enable SMbus support
            ...
```
```
Device Drivers  --->
    I2C support  --->
        [*]   ACPI I2C Operation region support
        [*]   Enable compatibility bits for old user-space
        ...
        [*]   Autoselect pertinent helper modules
```
```
Device Drivers  --->
    HID support  --->
        I2C HID support  --->
            <*> HID over I2C transport layer ACPI driver
```
