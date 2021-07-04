### Archlinux, with thunar
    thunar thunar-volman gvfs ntfs-3g udisds polkit

### Gentoo, with dolphin will auto install dependes

### mount a disk to find out deamon name:
    udisksctl mount -b /dev/sdb2
such as `org.freedesktop.udisks2.filesystem-mount-system`

### permit wheel group user excute deamon without passwd:
  
    nano /etc/polkit-1/rules.d/50-udiskie.rules
```
/* Allow members of the wheel group to execute the defined actions
 * without password authentication, similar to "sudo NOPASSWD:"
 */
polkit.addRule(function(action, subject) {
    if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
         action.id == "org.freedesktop.udisks2.filesystem-mount-system") &&
        subject.isInGroup("wheel"))
    {
        return polkit.Result.YES;
    }
});
```
