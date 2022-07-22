## souces  https://github.com/sddm/sddm
### compile from sources
```
mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release  \
      -DDBUS_CONFIG_FILENAME="org.freedesktop.sddm.conf"  \
      -DBUILD_MAN_PAGES=OFF  \
      -Wno-dev .. &&
make
make install
install --directory --mode=0755 --owner=root --group=root  /etc/sddm.conf.d
/usr/bin/sddm --example-config > /etc/sddm.conf.d/00default.conf
```

### add user
```
groupadd -g 64 sddm &&
useradd  -c "SDDM Daemon" \
         -d /var/lib/sddm \
         -u 64 -g sddm    \
         -s /bin/false sddm
gpasswd -a sddm video
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
`/etc/sddm.conf.d/default.conf`
#### sddm.conf
```
[Autologin]
# Whether sddm should automatically log back into sessions when they exit
Relogin=false

# Name of session file for autologin session (if empty try last logged in)
Session=

# Username for autologin session
User=


[General]
# Which display server should be used.
# Valid values are: x11, x11-user, wayland.
DisplayServer=x11

# Comma-separated list of environment variables to be set
GreeterEnvironment=

# Halt command
HaltCommand=/usr/bin/systemctl poweroff

# Input method module
#InputMethod=qtvirtualkeyboard
InputMethod=

# Comma-separated list of Linux namespaces for user session to enter
Namespaces=

# Initial NumLock state. Can be on, off or none.
# If property is set to none, numlock won't be changed
# NOTE: Currently ignored if autologin is enabled.
Numlock=none

# Reboot command
RebootCommand=/usr/bin/systemctl reboot


[Theme]
# Current theme name
Current=maldives

# Cursor size used in the greeter
CursorSize=

# Cursor theme used in the greeter
CursorTheme=

# Number of users to use as threshold
# above which avatars are disabled
# unless explicitly enabled with EnableAvatars
DisableAvatarsThreshold=7

# Enable display of custom user avatars
EnableAvatars=true

# Global directory for user avatars
# The files should be named <username>.face.icon
FacesDir=/usr/share/sddm/faces

# Font used in the greeter
Font=

# Theme directory path
ThemeDir=/usr/share/sddm/themes


[Users]
# Default $PATH for logged in users
DefaultPath=/usr/local/bin:/usr/bin:/bin

# Comma-separated list of shells.
# Users with these shells as their default won't be listed
HideShells=

# Comma-separated list of users that should not be listed
HideUsers=

# Maximum user id for displayed users
MaximumUid=60000

# Minimum user id for displayed users
#MinimumUid=1000
MinimumUid=0

# Remember the session of the last successfully logged in user
RememberLastSession=true

# Remember the last successfully logged in user
RememberLastUser=true

# When logging in as the same user twice, restore the original session, rather than create a new one
ReuseSession=true


[Wayland]
# Path of the Wayland compositor to execute when starting the greeter
CompositorCommand=weston --shell=fullscreen-shell.so

# Enable Qt's automatic high-DPI scaling
#EnableHiDPI=false
EnableHiDPI=true

# Path to a script to execute when starting the desktop session
SessionCommand=/usr/share/sddm/scripts/wayland-session

# Directory containing available Wayland sessions
SessionDir=/usr/share/wayland-sessions

# Path to the user session log file
SessionLogFile=.local/share/sddm/wayland-session.log


[X11]
# Path to a script to execute when starting the display server
DisplayCommand=/usr/share/sddm/scripts/Xsetup

# Path to a script to execute when stopping the display server
DisplayStopCommand=/usr/share/sddm/scripts/Xstop

# Enable Qt's automatic high-DPI scaling
EnableHiDPI=false

# Arguments passed to the X server invocation
ServerArguments=-nolisten tcp

# Path to X server binary
ServerPath=/usr/bin/X

# Path to a script to execute when starting the desktop session
SessionCommand=/usr/share/sddm/scripts/Xsession

# Directory containing available X sessions
SessionDir=/usr/share/xsessions

# Path to the user session log file
SessionLogFile=.local/share/sddm/xorg-session.log

# Path to the Xauthority file
UserAuthFile=.Xauthority

# Path to xauth binary
XauthPath=/usr/bin/xauth

# Path to Xephyr binary
XephyrPath=/usr/bin/Xephyr
```
### sddm start dwm
`/usr/share/xsessions/dwm.desktop`
```
[Desktop Entry]
Encoding=UTF-8
Name=DWM
Comment=Log in using the Dynamic Window Manager
Exec=/usr/bin/dwm
#Icon=/usr/bin/dwm.png
TryExec=/usr/bin/dwm
Type=XSession
```

- https://www.linuxfromscratch.org/blfs/view/8.1-systemd/x/sddm.html
