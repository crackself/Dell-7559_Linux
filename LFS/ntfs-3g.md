### 自5.15内核，自带NTFS驱动
```
File systems  --->
  <*/M> NTFS Read-Write file system support [CONFIG_NTFS3_FS]
```
```
cat >> /usr/sbin/mount.ntfs <<"EOF" &&
#!/bin/sh
exec mount -t ntfs3 "$@"
EOF
chmod -v 755 /usr/sbin/mount.ntfs
```

```
cat > /etc/udisks2/mount_options.conf << "EOF"
[defaults]
ntfs_defaults=uid=$UID,gid=$GID
EOF
```
