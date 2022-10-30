# file location /etc/profile.d/extrapath.sh
# Set custom CFLAGS
export CFLAGS="-march=native -O3 -pipe -fPIC"
export CXXFLAGS=$CFLAGS
export LDFLAGS=$CFLAGS
export OTHER_CFLAGS=$CFLAGS
export OTHER_CXXFLAGS=$CXXFLAGS
export OTHER_LDFLAGS=$LDFLAGS
export MAKEFLAGS='-j4'
export NINJAJOBS=4

# Set input method
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
