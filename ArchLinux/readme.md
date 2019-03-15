## 针对性屏蔽冲突的内核模块: 
### 屏蔽watchdog
### 安装broadcom-wl或broadcom-wl-dkms驱动（或者跟随内核升级，自动化构建）
### 屏蔽与DW1560(xx:43b1) BroadCom BCM94352Z专有驱动冲突的内核模块

for WD1560(Broadcom 4352Z, id= 14e4:43b1), need install `broadcom-wl`--the limited driver from broacom
then, diable other conflict kernel drivers.
Besides,you may notice that `watchdog` default turn on by kernel, it cause power down or reboot slowly, also blacklist it: 
On someones laptop, the dual graphic, especially the nvidia, you may want to disable opensoure driver. 
Berfore install limited driver from nvdia, blacklist `nouveau` help to save power and boot smoothly.

`nanoo /etc/modprobe.d/broadcom-wl-dkms.conf`
```
blacklist b43        # build-in kernel broadcom wifi driver - opensource
blacklist b43legacy  # build-in kernel broadcom wifi driver - opensource
blacklist bcm43xx    
blacklist bcma       
blacklist brcm80211  
blacklist brcmfmac   
blacklist brcmsmac   
blacklist ssb        
#blacklist wl        # provide by install broadcom-wl package, inflict to broadcom-wl-dkms

blacklist iTCO_wdt   # watchdog kernel module
blacklist nouveau    # nvidia opensource driver

```
### 安装搜狗输入法
```
sudo pacman -S fcitx-sogoupinyin
sudo pacman -S fcitx-im
sudo pacman -S fcitx-configtool
```

### 安装yarout
```
nano /etc/pacman.conf:
[archlinuxcn]
#The Chinese Arch Linux communities packages.
SigLevel = Optional TrustAll
Server   = http://repo.archlinuxcn.org/$arch
```
then,
`pacman -Syu yaourt`

## 安装蓝牙及蓝牙音频
```
pacman -S bluez blueman pulseaudio-bluetooth
```
#### BCM94352Z专用驱动
```
yaourt -S bcm20702a1-firmware
systemctl enable bluetooth.service
```
## xfce主题美化
```
yaourt -S gtk-theme-arc-git   # 窗口主题
pacman -S papirus-icon-theme  # 图标主题
```

## 安装 Bumblebee及Nvidia专有驱动
>> https://wiki.archlinux.org/index.php/Bumblebee
>> https://wiki.archlinux.org/index.php/NVIDIA_Optimus
```
sudo pacman -S bumblebee nvidia mesa mesa-demos virtualgl
sudo gpasswd -a username bumblebee    //把username换成自己的用户名
```
### 查找 3D Graphics
```
$ lspci | egrep 'VGA|3D'
-------------------------
00:02.0 VGA compatible controller: Intel Corporation HD Graphics 530 (rev 06)
02:00.0 3D controller: NVIDIA Corporation GM107M [GeForce GTX 960M] (rev a2)

```
### follow the Archlinux wiki,and check your install
#### Check The Status Of GPU

```
$ nvidia-smi
---------------
Sun Mar 10 18:39:30 2019       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 418.43       Driver Version: 418.43       CUDA Version: 10.1     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  GeForce GTX 960M    Off  | 00000000:02:00.0 Off |                  N/A |
| N/A   45C    P8    N/A /  N/A |      0MiB /  4046MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```
```
$ optirun glxspheres64
```
![test](https://github.com/crackself/Dell-7559_Linux/blob/master/ArchLinux/Screenshot.png)

