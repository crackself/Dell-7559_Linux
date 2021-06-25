### [slstatus](https://git.suckless.org/slstatus)，DWM的一个状态栏插件
    可用于显示音量、硬件信息、日期、天气(需配合自动化脚本)
#### 配置文件修改
##### config.def.h
```
...
static const struct arg args[] = {
	/* function format          argument */
	{ netspeed_rx,	"Down %s%| ", "enp4s0" },   /*下载网速*/
	{ netspeed_tx,	"Up %s%| ", "enp4s0" }, /*上传网速*/
	{ temp, "Tem %s\u00b0C| ", "/sys/class/thermal/thermal_zone2/temp" },   /*CPU温度*/
	{ cpu_perc,     "CPU %s%%| ", NULL },         /*CPU使用率*/
    { ram_perc,     "RAM %s%%| ", NULL },         /*内存使用率*/
    { disk_perc,    "HDD %s%%| ", "/" },         /*内存使用率*/
	{ run_command,  "Vol %2s| ", "amixer get Master | grep % | sed 's/[][]//g' | awk '{print $5}'" },         /*音量*/      
	/*{ battery_state, "%s"    , "BAT0" },*/    /*电池充电状态*/
	{ battery_perc,  "BAT %s%%| ", "BAT0" },	/*电池电量*/
	{ datetime, 	"%s",	"%B-%d %R" },         /*日期*/
};
```
#### 编译安装
```
make clean install
```
#### 通过xorg-xinit启动
`~/.xinitrc`
```
...
exec slstatus &
exec dwm
...
```
`startx`
