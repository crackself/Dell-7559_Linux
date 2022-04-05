### Building wireless driver as External Modules
    https://www.kernel.org/doc/html/latest/kbuild/modules.html    
### Sources link
    https://archlinux.org/packages/community/x86_64/broadcom-wl-dkms/
### Need
    a working kernel sources build directory

### patch
    patch -Np1 -i ./files/broadcom-sta-6.30.223.141-makefile.patch
    patch -Np1 -i ./files/broadcom-sta-6.30.223.248-r3-Wno-date-time.patch
    patch -Np1 -i ./files/broadcom-sta-6.30.223.141-gcc.patch
    patch -Np1 -i ./files/broadcom-sta-6.30.223.248-r3-Wno-date-time.patch
    patch -Np1 -i ./files/broadcom-sta-6.30.223.271-r1-linux-3.18.patch
    patch -Np1 -i ./files/broadcom-sta-6.30.223.271-r2-linux-4.3-v2.patch
    patch -Np1 -i ./files/broadcom-sta-6.30.223.271-r4-linux-4.7.patch
    patch -Np1 -i ./files/broadcom-sta-6.30.223.271-r4-linux-4.8.patch
    patch -Np1 -i ./files/broadcom-sta-6.30.223.271-r4-linux-4.11.patch
    patch -Np1 -i ./files/broadcom-sta-6.30.223.271-r4-linux-4.12.patch
    patch -Np1 -i ./files/broadcom-sta-6.30.223.271-r4-linux-4.15.patch
    patch -Np1 -i ./files/broadcom-sta-6.30.223.271-r5-linux-5.1.patch
    patch -Np1 -i ./files/broadcom-sta-6.30.223.271-r5-linux-5.6.patch
    patch -Np1 -i ./files/broadcom-sta-6.30.223.271-r6-linux-5.9.patch
### build and install
    make -C /lib/modules/`uname -r`/build M=$PWD
    make -C /lib/modules/`uname -r`/build M=$PWD modules_install
