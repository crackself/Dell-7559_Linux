# 说明
## 本文档专用记录Linux DWM 配置过程（所涉及组件参考Archlinux官方组件库）
### DWM及基础配套组件
    dwm dmenu xterminal
### 笔记本音量控制及屏幕亮度快捷键设置
#### 基本组件要求:
    
    X11图形服务:  xorg-server xorg-xinitrc  xf86-video-intel
    声音控制: alsa  alsa-utils  pulseaudio  pulseaudio-alsa
      二合一耳机插口:pulseaudio-jack
    背光控制: xorg-xbacklight
#### dwm 源码修改
#####  config.def.h 添加以下内容
    
    ...
    /* commands */
    s...tatic const char *termcmd[]  = { "st", NULL };
    static const char *volup[] = { "amixer", "-qM", "set", "Master", "2%+", "umute", NULL };
    static const char *voldown[] = { "amixer", "-qM", "set", "Master", "2%-", "umute", NULL };
    static const char *mute[] = { "amixer", "-qM", "set", "Master", "toggle", NULL };
    static const char *lightup[] = { "xbacklight", "-inc", "2", NULL };
    static const char *lightdown[] = { "xbacklight", "-dec", "2", NULL };

    static Key keys[] = {
            /* modifier                     key        function        argument */
            { MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
            { 0,              XF86XK_AudioRaiseVolume, spawn,          {.v = volup } },
            { 0,              XF86XK_AudioLowerVolume, spawn,          {.v = voldown } },
            { 0,              XF86XK_AudioMute,        spawn,          {.v = mute } },
            { 0,                            XF86XK_MonBrightnessDown,   spawn,      {.v = lightdown } },
            { 0,                            XF86XK_MonBrightnessUp,     spawn,      {.v = lightup } },
            { MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
            ....
#### dwm.c 添加`#include <X11/Xutil.h>`
    ...
    #include <X11/Xutil.h>
    #include <X11/XF86keysym.h>
    #ifdef XINERAMA
    ...
 ### 其他显示显示效果组件(可选)