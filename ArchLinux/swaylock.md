### swaylock无法解锁屏幕
#### 修改`/etc/pam.d/swaylock`通过`system-auto`授权解锁服务
```
#
# PAM configuration file for the swaylock screen locker. By default, it includes
# the 'login' configuration file (see /etc/pam.d/login)
#

#auth include login
auth include system-auth
```
