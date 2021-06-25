# 说明
## 本文档专用记录Linux DWM 配置过程（所涉及组件参考Archlinux官方组件库）
### DWM及基础配套组件
    dwm dmenu st
### 笔记本音量控制及屏幕亮度快捷键设置
#### 基本组件要求:
    
    X11图形服务:  xorg-server xorg-xinitrc libxft xf86-video-intel
    声音控制: alsa-utils  pulseaudio pulseaudio-alsa (可选pulseaudio-jack)  
        # pulseaudio 配合pactl set-sink-mute 0 toggle可同时控制耳机静音
      二合一耳机插口:pulseaudio-jack
    背光控制: xorg-xbacklight
### 字体要求：
        ttf-nerd-fonts-symbols
        对应的图标字体https://www.nerdfonts.com/cheat-sheet
#### dwm 源码修改
#####  config.def.h：
        /* See LICENSE file for copyright and license details. */
        /* appearance */
        static const unsigned int borderpx  = 1;        /* border pixel of windows */
        static const unsigned int snap      = 32;       /* snap pixel */
        static const int showbar            = 1;        /* 0 means no bar */
        static const int topbar             = 1;        /* 0 means bottom bar */
        static const char *fonts[]          = { "Sauce Code Pro Nerd Font Mono:size=15" };
        static const char dmenufont[]       = "Sauce Code Pro Nerd Font Mono:size=15";
        static const char col_gray1[]       = "#D8DEE9";
        static const char col_gray2[]       = "#434C5E";
        static const char col_gray3[]       = "#434C5E";
        static const char col_gray4[]       = "#eeeeee";
        static const char col_cyan[]        = "#005577";
        static const char *colors[][3]      = {
            /*               fg         bg         border   */
            [SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
            [SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
        };

        /* tagging */
        static const char *tags[] = { "", "", "", "", "", "" };

        static const Rule rules[] = {
            /* xprop(1):
             *	WM_CLASS(STRING) = instance, class
             *	WM_NAME(STRING) = title
             */
            /* class      instance    title       tags mask     isfloating   monitor */
            { "Gimp",     NULL,       NULL,       0,            1,           -1 },
            { "firefox",  NULL,       NULL,       1 << 1,       1,           -1 },
            { "Thunar",  NULL,       NULL,       1 << 2,       0,           -1 },
            { "mpv",  NULL,       NULL,       1 << 3,       0,           -1 },
            { "Alacritty",  NULL,       NULL,       1 << 5,       0,           -1 },
        };

        /* layout(s) */
        static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
        static const int nmaster     = 1;    /* number of clients in master area */
        static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

        static const Layout layouts[] = {
            /* symbol     arrange function */
            { "平铺",      tile },    /* first entry is default */
            { "浮动",      NULL },    /* no layout function means floating behavior */
            { "[M]",      monocle },
        };

        /* key definitions */
        #define MODKEY Mod1Mask
        #define TAGKEYS(KEY,TAG) \
            { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
            { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
            { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
            { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

        /* helper for spawning shell commands in the pre dwm-5.0 fashion */
        #define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

        /* commands */
        static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
        static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
        static const char *termcmd[]  = { "alacritty", NULL };
        static const char *volup[] = { "amixer", "-qM", "set", "Master", "2%+", "umute", NULL };
        static const char *voldown[] = { "amixer", "-qM", "set", "Master", "2%-", "umute", NULL };
        static const char *mute[] = { "amixer", "-qM", "set", "Master", "toggle", NULL };
        /*static const char *mute[] = { "pactl", "set-sink-mute", "0", "toggle", NULL };*/
        static const char *lightup[] = { "xbacklight", "-inc", "5", NULL };
        static const char *lightdown[] = { "xbacklight", "-dec", "5", NULL };


        static Key keys[] = {
            /* modifier                     key        function        argument */
            { 0,              XF86XK_AudioRaiseVolume, spawn,          {.v = volup } },
                { 0,              XF86XK_AudioLowerVolume, spawn,          {.v = voldown } },
                { 0,              XF86XK_AudioMute,        spawn,          {.v = mute } },
                { 0,                            XF86XK_MonBrightnessDown,   spawn,      {.v = lightdown } },
                { 0,                            XF86XK_MonBrightnessUp,     spawn,      {.v = lightup } },
            { MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
            { MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
            { MODKEY,                       XK_b,      togglebar,      {0} },
            { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
            { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
            { MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
            { MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
            { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
            { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
            { MODKEY,                       XK_Return, zoom,           {0} },
            { MODKEY,                       XK_Tab,    view,           {0} },
            { MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
            { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
            { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
            { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
            { MODKEY,                       XK_space,  setlayout,      {0} },
            { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
            { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
            { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
            { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
            { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
            { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
            { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
            TAGKEYS(                        XK_1,                      0)
            TAGKEYS(                        XK_2,                      1)
            TAGKEYS(                        XK_3,                      2)
            TAGKEYS(                        XK_4,                      3)
            TAGKEYS(                        XK_5,                      4)
            TAGKEYS(                        XK_6,                      5)
            { MODKEY|ShiftMask,             XK_q,      quit,           {0} },
        };

        /* button definitions */
        /* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
        static Button buttons[] = {
            /* click                event mask      button          function        argument */
            { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
            { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
            { ClkWinTitle,          0,              Button2,        zoom,           {0} },
            { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
            { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
            { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
            { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
            { ClkTagBar,            0,              Button1,        view,           {0} },
            { ClkTagBar,            0,              Button3,        toggleview,     {0} },
            { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
            { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
        };

#### dwm.c 添加`#include <X11/XF86keysym.h>`
    ...
    #include <X11/Xutil.h>
    #include <X11/XF86keysym.h>
    #ifdef XINERAMA
    ...
 ### 其他显示显示效果组件(可选)
