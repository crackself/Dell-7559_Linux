### Building wireless driver as External Modules
    https://www.kernel.org/doc/html/latest/kbuild/modules.html    
### Sources link
    https://archlinux.org/packages/community/x86_64/broadcom-wl-dkms/
### Need
    a working kernel sources build directory
#### 前提：有在使用中订内核源码及完成编译的目录
### 通用Patch (参考Archlinux)
```
patch -Np1 -i ../patch/000-eth-to-wlan.patch
patch -Np1 -i ../patch/001-null-pointer-fix.patch
patch -Np1 -i ../patch/002-rdtscl.patch
patch -Np1 -i ../patch/003-linux47.patch
patch -Np1 -i ../patch/004-linux48.patch
patch -Np1 -i ../patch/005-debian-fix-kernel-warnings.patch
patch -Np1 -i ../patch/006-linux411.patch
patch -Np1 -i ../patch/007-linux412.patch
patch -Np1 -i ../patch/008-linux415.patch
#patch -Np1 -i ../patch/009-fix_mac_profile_discrepancy.patch
patch -Np1 -i ../patch/010-linux56.patch
patch -Np1 -i ../patch/011-linux59.patch
patch -Np1 -i ../patch/012-linux517.patch
patch -Np1 -i ../patch/013-linux518.patch
patch -Np1 -i ../patch/015-linux600.patch
patch -Np1 -i ../patch/016-linux601.patch
```

#### Gentoo patch (依赖Gentooemerge安装内核，Gentoo官方已停止更新)
```
patch -Np1 -i ../patch/old/broadcom-sta-6.30.223.141-makefile.patch
patch -Np1 -i ../patch/old/broadcom-sta-6.30.223.141-eth-to-wlan.patch
patch -Np1 -i ../patch/old/broadcom-sta-6.30.223.141-gcc.patch
patch -Np1 -i ../patch/old/broadcom-sta-6.30.223.248-r3-Wno-date-time.patch
patch -Np1 -i ../patch/old/broadcom-sta-6.30.223.271-r1-linux-3.18.patch
patch -Np1 -i ../patch/old/broadcom-sta-6.30.223.271-r2-linux-4.3-v2.patch
patch -Np1 -i ../patch/old/broadcom-sta-6.30.223.271-r4-linux-4.7.patch
patch -Np1 -i ../patch/old/broadcom-sta-6.30.223.271-r4-linux-4.8.patch
patch -Np1 -i ../patch/old/broadcom-sta-6.30.223.271-r4-linux-4.11.patch
patch -Np1 -i ../patch/old/broadcom-sta-6.30.223.271-r4-linux-4.12.patch
patch -Np1 -i ../patch/old/broadcom-sta-6.30.223.271-r4-linux-4.15.patch
patch -Np1 -i ../patch/old/broadcom-sta-6.30.223.271-r5-linux-5.1.patch
patch -Np1 -i ../patch/old/broadcom-sta-6.30.223.271-r5-linux-5.6.patch
patch -Np1 -i ../patch/old/broadcom-sta-6.30.223.271-r6-linux-5.9.patch
patch -Np1 -i ../patch/old/broadcom-sta-6.30.223.271-r6-linux-5.17.patch
patch -Np1 -i ../patch/old/linux518.patch
patch -Np1 -i ../patch/old/linux600.patch
patch -Np1 -i ../patch/old/linux601.patch
```
### fix Makefile, remove gcc version check
`sed -i -e ";/GE_49 :=/s|:= .*|:= 1|" Makefile`
### build and install
```
make -C /lib/modules/`uname -r`/build M=$PWD
make -C /lib/modules/`uname -r`/build M=$PWD modules_install
```
