## LFS chroot
```
export LFS=/mnt/lfs
mount -v --bind /dev $LFS/dev
mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi

chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin     \
    /bin/bash --login +h

export PS1="(chroot) ${PS1}"

退出
umount $LFS/dev/pts
umount $LFS/{sys,proc,run,dev}
findmnt | grep $LFS
```
## zstd backup
```
zstd 压缩备份及解压
cd [需要备份的目录]
tar --zstd -cvpf [输出目录] --exclude=[排除文件路经（在需要备份目录执行则是相对路经）] .

tar --zstd -cvpf $HOME/test.zst --exclude=wenzhi .
tar --zstd -xpf directory.tar.zst ./
```
