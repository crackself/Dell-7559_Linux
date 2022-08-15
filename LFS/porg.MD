### build and install package with porg manager, under "blfs_root"
`001-z-alacritty` 文件放在blfs_root/scripts目录，执行
```
cd blfs_root/work
../gen-makefile.sh
make
```
以完成安装
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
### 以下alacritty改为对应软件包的名称
export JH_PKG_DIR=alacritty
SRC_DIR=${JH_SRC_ARCHIVE}${JH_SRC_SUBDIRS:+/${JH_PKG_DIR}}
BUILD_DIR=${JH_BUILD_ROOT}${JH_BUILD_SUBDIRS:+/${JH_PKG_DIR}}
mkdir -p $SRC_DIR
mkdir -p $BUILD_DIR

cd $SRC_DIR
### 以下alacritty-0.10.1.tar.gz改为对应软件包的源码文件名称
PACKAGE=alacritty-0.10.1.tar.gz
if [[ ! -f $PACKAGE ]] ; then
  if [ -f "$JH_SRC_ARCHIVE/$PACKAGE" ] ; then
    cp "$JH_SRC_ARCHIVE/$PACKAGE" "$PACKAGE"
  else
    ### 以下"网址"改为对应软件包的源码文件下载网址
    wget -T 30 -t 5 "https://github.com/alacritty/alacritty/archive/refs/tags/v0.10.1.tar.gz" ||
    wget -T 30 -t 5 "ftp://github.com/alacritty/alacritty/archive/refs/tags/v0.10.1.tar.gz" ||
    wget -T 30 -t 5 "${JH_FTP_SERVER}svn/t/$PACKAGE"
  fi
fi
## 以下814f74f8a1a4cfc73db9959a06c27291改为对应软件包的源码文件md5校验值
echo "814f74f8a1a4cfc73db9959a06c27291  $PACKAGE" | md5sum -c -

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

make
if [ -r "$JH_PACK_INSTALL" ]; then
  source $JH_PACK_INSTALL
  export -f wrapInstall
  export -f packInstall
fi
wrapInstall '
####
#此部分为编译、安装命令，按顺序逐行填写
cargo build --release
cp target/release/alacritty /usr/bin/
cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
desktop-file-install extra/linux/Alacritty.desktop
#结束
####
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
