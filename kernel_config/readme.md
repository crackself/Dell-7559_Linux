#### 安装内核到
5.14.9 以上均默认去除`early print`
*-vm 配置文件开启qemu
6.15.6 以上均默認啓用AX210網卡，需要固件支持，need-firmware.tar.xz 需解壓到/lib/firmware確保生效
其它为缺省配置
#### 安装内核到`/usr/src/`:
    
`tar -xf linux-5.13.2.tar.xz /usr/src/linux`
    
#### 清理旧文件
`make mrproper`
        
#### 取消`kernel debug`选项:
    
`sed -i '/select DEBUG_KERNEL/d' init/Kconfig`

#### 配置选项，使用Clang编译:
`make menuconfig CC=clang HOSTCC=clang`

`make -j4 CC=clang HOSTCC=clang`

#### 手动安装引导文件到`/boot`
```
cp -iv arch/x86/boot/bzImage /boot/vmlinuz
cp -iv System.map /boot/System.map
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
