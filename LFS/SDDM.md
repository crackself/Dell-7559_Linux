## souces  https://github.com/sddm/sddm
### compile from sources
```
mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release  \
      -Wno-dev .. &&
make
make install
```

### add user
```
groupadd -g 64 sddm &&
useradd  -c "SDDM Daemon" \
         -d /var/lib/sddm \
         -u 64 -g sddm    \
         -s /bin/false sddm

install -v -dm755 -o sddm -g sddm /var/lib/sddm
```
### Linux PAM Configuration 
```
cat > /etc/pam.d/sddm << "EOF" &&
# Begin /etc/pam.d/sddm

auth     requisite      pam_nologin.so
auth     required       pam_env.so

auth     required       pam_succeed_if.so uid >= 1000 quiet
auth     include        system-auth

account  include        system-account
password include        system-password

session  required       pam_limits.so
session  include        system-session

# End /etc/pam.d/sddm
EOF

cat > /etc/pam.d/sddm-autologin << "EOF" &&
# Begin /etc/pam.d/sddm-autologin

auth     requisite      pam_nologin.so
auth     required       pam_env.so

# disable for allow root login
#auth     required       pam_succeed_if.so uid >= 1000 quiet

auth     required       pam_permit.so

account  include        system-account

password required       pam_deny.so

session  required       pam_limits.so
session  include        system-session

# End /etc/pam.d/sddm-autologin
EOF

cat > /etc/pam.d/sddm-greeter << "EOF"
# Begin /etc/pam.d/sddm-greeter

auth     required       pam_env.so
auth     required       pam_permit.so

account  required       pam_permit.so
password required       pam_deny.so
session  required       pam_unix.so
-session optional       pam_systemd.so

# End /etc/pam.d/sddm-greeter
EOF
```
### SDDM config files
`/etc/sddm.conf.d/*.conf`
#### sddm.conf
```
[Autologin]
Relogin=false
Session=
User=

[General]
HaltCommand=
RebootCommand=
InputMethod=

[Theme]
#elarun  maldives  maya
Current=maldives

[Users]
MaximumUid=60000
# set minimum to 0 for allow root
#MinimumUid=1000
MinimumUid=0
```

- https://www.linuxfromscratch.org/blfs/view/8.1-systemd/x/sddm.html
