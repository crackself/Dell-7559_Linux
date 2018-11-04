### custome kernel model blacklist: for disalbe watchdog and load custom broadcom wifi driver for DW1560(xx:43b1)

for WD1560(Broadcom 4352Z, id= 14e4:43b1), need install `broadcom-wl`--the limited driver from broacom
then, diable other conflict kernel drivers:
`nanoo /etc/modprobe.d/custom.conf`
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
```
besides,you may notice that `watchdog` default turn on by kernel, it cause power down or reboot slowly, also blacklist it:
`blacklist iTCO_wdt   # watchdog kernel module`
On someones laptop, the dual graphic, especially the nvidia, you may want to disable opensoure driver. 
Berfore install limited driver from nvdia, blacklist `nouveau` help to save power and boot smoothly.
`blacklist nouveau    # nvidia opensource driver`