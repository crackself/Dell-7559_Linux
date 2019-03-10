### custome kernel model blacklist: for disalbe watchdog and load custom broadcom wifi driver for DW1560(xx:43b1)

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
### Install yarout package manage tool

```
nano /etc/pacman.conf:
[archlinuxcn]
#The Chinese Arch Linux communities packages.
SigLevel = Optional TrustAll
Server   = http://repo.archlinuxcn.org/$arch
```
then,
`pacman -Syu yaourt`

## Install Bumblebee and nvidia driver
>> https://wiki.archlinux.org/index.php/Bumblebee
>> https://wiki.archlinux.org/index.php/NVIDIA_Optimus
```
sudo pacman -S bumblebee bbswitch nvidia mesa-demos virtualgl
sudo gpasswd -a username bumblebee    //把username换成自己的用户名
```
### Know your 3D Graphics
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
