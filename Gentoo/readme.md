### BroadCom BCM94352Z wireless driver: Broadcom-sta (broadcom-wl)

```
USE:
X aac acpi alsa ao bluetooth bzip2 cdr cjk cups curl dts dvd encode ffmpeg flac geoip gif git gpm gzip hddtemp javascript jack jbig jpeg jpeg2k kde lame lm_sensors lzma mmap mms mp3 mp4 mpeg multilib networkmanager nls pdf plasma png python qt5 raw sockets socks5 sound ssl svg tiff udev udisks unicode usb upower upnp 
wifi wmf zip zlib zsh-completion
-gnome -systemd -gtk
```
### EFI partition mount on /boot/efi

#### install grub2 for bootloader
```
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Gentoo
grub-mkconfig -o /boot/grub/grub.cfg
```

>> https://blog.yangmame.org/Gentoo%E5%AE%89%E8%A3%85%E6%95%99%E7%A8%8B.html
>> https://wiki.gentoo.org/wiki/Handbook:AMD64/zh-cn
>> https://wiki.gentoo.org/wiki/Dell_XPS_13_9343 (For configure wireless and bluetooth)
