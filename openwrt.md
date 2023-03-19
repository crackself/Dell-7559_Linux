### OpenwrtImagerBuilder快速生成镜像 
```
make image PACKAGES=" -firewall4 -dnsmasq -ppp -ppp-mod-pppoe -kmod-amazon-ena -kmod-amd-xgbe -kmod-bnx2 -kmod-button-hotplug -kmod-r8169 -kmod-tg3 -libustream-wolfssl -grub2-bios-setup firewall dnsmasq-full lsblk fdisk losetup resize2fs nano kmod-tcp-bbr kmod-ipt-tproxy kmod-ipt-nat6 kmod-nf-tproxy kmod-ipt-raw kmod-ipt-conntrack ip-full iptables-mod-tproxy iptables-mod-filter iptables-mod-conntrack-extra iptables-mod-u32 iptables-mod-extra wget-ssl curl wpad-openssl v2ray-geoip v2ray-geosite v2ray-core v2ray-extra dockerd luci luci-i18n-base-zh-cn luci-theme-material luci-i18n-dockerman-zh-cn luci-i18n-opkg-zh-cn luci-i18n-nlbwmon-zh-cn" FILES="./files"
```
#### openwrt uci 设置Dnsmasq KMS规则，自动激活windows/office
```
/etc/dnsmasq.conf
# srv-host=_vlmcs._tcp.lan,OpenWrt.lan,1688,0,100
```

```
uci add dhcp srvhost
uci set	dhcp.@srvhost[-1].srv="_vlmcs._tcp.lan"
uci set	dhcp.@srvhost[-1].target="OpenWrt.lan"
uci set	dhcp.@srvhost[-1].port="1688"
uci set	dhcp.@srvhost[-1].class="0"
uci set	dhcp.@srvhost[-1].weight="100"
uci commit dhcp
/etc/init.d/dnsmasq restart
```
### uci 修改LAN地址
```
set network.lan.ipaddr='192.168.100.1'
commit network
/etc/init.d/network reload
```
### uci 修改dockerd 启用外网连接到容器
```
/etc/init.d/dnsmasq restart
uci set dockerd.firewall.extra_iptables_args='--match conntrack ! --ctstate RELATED,ESTABLISHED'
uci commit dockerd
```

#### openwrt开机自动脚本执行uci
`/etc/uci-defaults/99-custom`
```
uci -q batch << EOI
# 此处为uci命令
#
EOI
```
