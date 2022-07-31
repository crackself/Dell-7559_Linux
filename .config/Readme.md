# Shell相关设置推荐参考[BLFS](https://www.linuxfromscratch.org/blfs/view/systemd/postlfs/profile.html)

## 自动应用到新用户的配置文件推荐放到`/etc/skel/`目录

### 通过配置文件设置plasma桌面语言
```
/etc/skel/plasma-localerc

[Formats]
LANG=zh_CN.utf8
```
