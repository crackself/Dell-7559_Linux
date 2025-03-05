## 使用quickpkg打包emerge安装的软件，以便后续直接使用二进制安装包

### 备份二进制包
### 安装打包好的二进制包
如：  

```
# chromium
quickpkg www-client/chromium

# firefox
quickpkg www-client/firefox

# gcc
sys-devel/gcc

# nodejs
net-libs/nodejs

# llvm
llvm-core/llvm

# clang
llvm-core/clang

# blender
media-gfx/blender

# gimp
media-gfx/gimp
```

或者直接打包所有已安装的软件包：  
`quickpkg --include-config y @world`

### 在其他Gentoo系统上，可以使用emerge安装：
```
emerge --usepkg /path/to/package.tbz2
```
