### PAM rules
#### for other program like kscreenlocker
```
/etc/pam.d/other
```
```
# Begin /etc/pam.d/other

#auth        required        pam_warn.so
#auth        required        pam_deny.so
auth        required        pam_unix.so
#account     required        pam_warn.so
#account     required        pam_deny.so
account     required        pam_unix.so
#password    required        pam_warn.so
#password    required        pam_deny.so
password    required        pam_unix.so
#session     required        pam_warn.so
#session     required        pam_deny.so
session     required  	    pam_unix.so
# End /etc/pam.d/other
```
