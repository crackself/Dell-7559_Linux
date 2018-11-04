### custome kernel model blacklist: for disalbe watchdog and load custom broadcom wifi driver for DW1560(xx:43b1)

`
nanoo /etc/modprobe.d/custom.conf
`
```
blacklist iTCO_wdt   # watchdog kernel module
blacklist nouveau    # nvidia opensource driver
blacklist b43        # build-in kernel broadcom wifi driver - opensource
blacklist b43legacy  # build-in kernel broadcom wifi driver - opensource
blacklist bcm43xx    # litmit broadcom wifi driver
blacklist bcma       # litmit broadcom wifi driver
blacklist brcm80211  # litmit broadcom wifi driver
blacklist brcmfmac   # litmit broadcom wifi driver
blacklist brcmsmac   # litmit broadcom wifi driver
blacklist ssb        # litmit broadcom wifi driver
#blacklist wl        # litmit broadcom wifi driver  provide by install broadcom-wl package, inflict to broadcom-wl-dkms
```
