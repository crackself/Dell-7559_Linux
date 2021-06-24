### Test in Archlinux, with thunar
`udisds`  for automount
`polkit` for AUTHENTICATION

`udisksctl mount -b /dev/sdb2`
to findout deamon name, such as `org.freedesktop.udisks2.filesystem-mount-system`

permit wheel group user excute without passwd:
  
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
