## 去除无效订阅弹窗
### 解决方法1：
搜索关键词：`data.status`
将：
```
    if (res === null || res === undefined || !res || res
    .data.status.toLowerCase() !== 'active') {
```
修改为
```
    if (false) {
```
### 解决方法2 （pve8.3测试有效）
搜索关键词：`Ext.Msg.show`
将：
```
    Ext.Msg.show({
```
修改为：
```
    Ext.Msg.noshow({
```
文件修改后保存上传，执行 `systemctl restart pveproxy` 命令重启网页服务
注销后登陆，使用 `CTRL + F5`捷键强制重新加载网页页面，或清理浏览器缓存（很多修改后没有反应的童学记得清缓存）
再次打开登陆 Proxmox VE系统控制台主界面，就没有弹窗提示了。
### 参考链接
- https://vps.la/2021/11/30/proxmox-vepve%E7%B3%BB%E7%BB%9F%E7%A7%BB%E9%99%A4%E3%80%8A%E6%97%A0%E6%9C%89%E6%95%88%E8%AE%A2%E9%98%85%E3%80%8B%E5%BC%B9%E7%AA%97%E6%8F%90%E7%A4%BA%E9%80%9A%E7%9F%A5/
