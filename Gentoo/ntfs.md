###  开启编译内核驱动
```
CONFIG_NTFS_FS=y
```

### udisk 使用内核驱动
```
cat > /etc/udisks2/mount_options.conf << "EOF"
[defaults]
ntfs_defaults=uid=$UID,gid=$GID
EOF
```
```
cat >> /usr/sbin/mount.ntfs <<"EOF" &&
#!/bin/sh
exec mount -t ntfs3 "$@"
EOF
chmod -v 755 /usr/sbin/mount.ntfs
```
