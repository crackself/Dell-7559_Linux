#### 安装内核到`/usr/src/`:
    
`tar -xf linux-5.13.2.tar.xz /usr/src/linux`
    
#### 取消`kernel debug`选项:
    
`sed -i '/select DEBUG_KERNEL/d' /usr/src/linux/init/Kconfig`

#### 使用Clang编译:
    
`make -j4 CC=clang HOSTCC=clang`

#### 手动安装引导文件到`/boot`
```
cp -iv arch/x86/boot/bzImage /boot/vmlinuz-5.13.2
cp -iv System.map /boot/System.map-5.13.2`
```

#### 手动安装kernek modules 到
`make modules_install`

### 更新GRUB引导
#### 自动
`grub-mkconfig -o /boot/grub/grub.cfg`

#### 手动
##### MBR分区磁盘
hd0 表示第一个磁盘，2 表示第二个分区
```
cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod ext2
set root=(hd0,2)

menuentry "GNU/Linux, Linux 5.13.2" {
        linux   /boot/vmlinuz-5.13.2 root=/dev/sda2 ro
}
EOF
```
##### GUID分区磁盘
hd0 表示第一个磁盘，gpt2 表示第二个分区
```
cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod ext2
set root=(hd0,gpt2)

menuentry "GNU/Linux, Linux 5.13.2" {
        linux   /boot/vmlinuz-5.13.2 root=/dev/sda2 ro
}
EOF
```
