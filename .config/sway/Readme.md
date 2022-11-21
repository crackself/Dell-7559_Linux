### XDG_RUNTIME_DIR
```
# fix not visible cursor on sway
export WLR_NO_HARDWARE_CURSORS=1

# set XDG_RUNTIME_DIR fore sway
if test -z"${XDG_RUNTIME_DIR}"; then
       	export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
       	if ! test -d "${XDG_RUNTIME_DIR}"; then
               	mkdir "${XDG_RUNTIME_DIR}"
               	chmod 0700 "${XDG_RUNTIME_DIR}"
       	fi
fi

# auto start sway
dbus-run-session sway
```
#### menu launcher
```
wofi  config as bindsym $mod+p exec wofi --gtk-dark --show run
fcitx5-rime (wayland not need libnotify)  
fcitx5-gtk
```

