### BLFS自动编译脚本使用
#### 通过ALFS自动编译LFS(jhalfs)，务必勾选Add blfs-tool support以生成blfs_root。packagmanager选择porg
```
→ BOOK Settings 
    [*] Add blfs-tool support
        [*] libxml2 (required)
        [*] libxslt (required)
        [*] DocBook XML DTD (required)
        [ ] lynx (optional, for reading the generated book)
        [*] sudo (recommended)
        [*] wget (recommended)
```
#### 完成LFS基础系统编译后，chroot到LFS，`/blfs_root` 即是BLFS自动便宜脚本，仅能在主目录使用
`cp -rf /blfs_root ~`
##### 修改对应packmanager安装脚本位置为主目录内
`cd ~/blfs_root`
`make`
```
→ Build settings
    (/root/blfs_root/packInstall.sh) Location of the packInstall.sh script (NEW)
```

BLFS book以外软件通过`/blfs_root`自动编译：
- 先通过`/blfs_root`自动编译任一组件，确保`/blfs_root`可正常工作。
- `~/blfs_root/scripts`内为对应软件包自动编译安装脚本，参照其格式修改`编译命令行`及`安装命令行部分`
- `~/blfs_root/work` 为执行编译目录，先后执行'../gen-makefile.sh' 'make'即可完成
#### `~/blfs_root/scripts`例子
`001-z-sway`
```
#!/bin/bash
set -e
# Variables coming from configuration
export JH_PACK_INSTALL="/root/blfs_root/packInstall.sh"
export JH_SRC_ARCHIVE="/sources"
export JH_SRC_SUBDIRS=""
export JH_BUILD_ROOT="/sources"
export JH_BUILD_SUBDIRS="y"
export JH_KEEP_FILES=""
export CFLAGS="-O3 -pipe -march=native -fPIC"
export CXXFLAGS="-O3 -pipe -march=native -fPIC"
export LDFLAGS="-O3 -pipe -march=native -fPIC"
export MAKEFLAGS="-j4"
export NINJAJOBS="4"
unset MAKELEVEL
unset MAKE_TERMOUT
unset MAKE_TERMERR
if [ -r /etc/profile ]; then source /etc/profile; fi
# End of environment
export JH_PKG_DIR=sway      # 此为编译工作目录，位于/sources内
SRC_DIR=${JH_SRC_ARCHIVE}${JH_SRC_SUBDIRS:+/${JH_PKG_DIR}}
BUILD_DIR=${JH_BUILD_ROOT}${JH_BUILD_SUBDIRS:+/${JH_PKG_DIR}}
mkdir -p $SRC_DIR
mkdir -p $BUILD_DIR

cd $SRC_DIR
PACKAGE=sway-1.8.tar.gz     # 此为源码压缩包，位于/sources内

cd $BUILD_DIR
find . -maxdepth 1 -mindepth 1 -type d | xargs rm -rf

case $PACKAGE in
  *.tar.gz|*.tar.bz2|*.tar.xz|*.tgz|*.tar.lzma)
     tar -xvf $SRC_DIR/$PACKAGE > unpacked
     JH_UNPACKDIR=`grep '[^./]\+' unpacked | head -n1 | sed 's@^\./@@;s@/.*@@'`
     ;;
  *.tar.lz)
     bsdtar -xvf $SRC_DIR/$PACKAGE 2> unpacked
     JH_UNPACKDIR=`head -n1 unpacked | cut  -d" " -f2 | sed 's@^\./@@;s@/.*@@'`
     ;;
  *.zip)
     zipinfo -1 $SRC_DIR/$PACKAGE > unpacked
     JH_UNPACKDIR="$(sed 's@/.*@@' unpacked | uniq )"
     if test $(wc -w <<< $JH_UNPACKDIR) -eq 1; then
       unzip $SRC_DIR/$PACKAGE
     else
       JH_UNPACKDIR=${PACKAGE%.zip}
       unzip -d $JH_UNPACKDIR $SRC_DIR/$PACKAGE
     fi
     ;;
  *)
     JH_UNPACKDIR=$JH_PKG_DIR-build
     mkdir $JH_UNPACKDIR
     cp $SRC_DIR/$PACKAGE $JH_UNPACKDIR
     ADDITIONAL="$(find . -mindepth 1 -maxdepth 1 -type l)"
     if [ -n "$ADDITIONAL" ]; then
         cp $ADDITIONAL $JH_UNPACKDIR
     fi
     ;;
esac
export JH_UNPACKDIR
cd $JH_UNPACKDIR
###             编译命令行
mkdir build
cd    build

meson --prefix=/usr -Dman-pages=disabled ..
ninja
###             结束编译命令行 
if [ -r "$JH_PACK_INSTALL" ]; then
  source $JH_PACK_INSTALL
  export -f wrapInstall
  export -f packInstall
fi
wrapInstall '
###             安装命令行
ninja install
####            结束安装命令行
for libdir in /lib /usr/lib $(find /opt -name lib); do
  find $libdir -name \*.la           \
             ! -path \*ImageMagick\* \
               -delete
done'
packInstall
ldconfig

cd $BUILD_DIR
[[ -n "$JH_KEEP_FILES" ]] || rm -rf $JH_UNPACKDIR unpacked

exit
```
