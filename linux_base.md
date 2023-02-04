### 查看硬件温度
文件位置，x86_pkg_temp为CPU
```	
cat /sys/class/thermal/thermal_zone*/temp
```
```
cat /sys/class/thermal/thermal_zone*/temp
```
- https://www.linuxfordevices.com/tutorials/linux/check-cpu-and-gpu-temperatures

### find key world in Document
```
grep -Rw [Document Path] -e [Key World]
```
### update icon cache
`gtk-update-icon-cache /usr/share/icons/Adwaita`

### ALSA 声卡耳机输出不自动识别、声道错误等等，需要重置ALSA配置 `alsactl init`
```
alsactl -h
global options:
  -h,--help        this help
  -d,--debug       debug mode
  -v,--version     print version of this program

Available state options:
  -f,--file #      configuration file (default /var/lib/alsa/asound.state)
  -a,--config-dir #  boot / hotplug configuration directory (default /var/lib/alsa)
  -l,--lock        use file locking to serialize concurrent access
  -L,--no-lock     do not use file locking to serialize concurrent access
  -K,--lock-dir #  lock path (default /var/lock)
  -O,--lock-state-file #  state lock file path (default asound.state.lock)
  -F,--force       try to restore the matching controls as much as possible
                     (default mode)
  -g,--ignore      ignore 'No soundcards found' error
  -P,--pedantic    do not restore mismatching controls (old default)
  -I,--no-init-fallback
                   don't initialize even if restore fails
  -r,--runstate #  save restore and init state to this file (only errors)
                     default settings is 'no file set'
  -R,--remove      remove runstate file at first, otherwise append errors
  -p,--period #    store period in seconds for the daemon command
  -e,--pid-file #  pathname for the process id (daemon mode)

Available init options:
  -E,--env #=#     set environment variable for init phase (NAME=VALUE)
  -i,--initfile #  main configuation file for init phase
                     (default /usr/share/alsa/init/00main)
  -b,--background  run daemon in background
  -s,--syslog      use syslog for messages
  -n,--nice #      set the process priority (see 'man nice')
  -c,--sched-idle  set the process scheduling policy to idle (SCHED_IDLE)
  -D,--ucm-defaults  execute also the UCM 'defaults' section
  -U,--no-ucm      don't init with UCM
  -X,--ucm-nodev   show UCM no device errors

Available commands:
  store       <card>  save current driver setup for one or each soundcards
                        to configuration file
  restore     <card>  load current driver setup for one or each soundcards
                        from configuration file
  nrestore    <card>  like restore, but notify the daemon to rescan soundcards
  init        <card>  initialize driver to a default state
  daemon      <card>  store state periodically for one or each soundcards
  rdaemon     <card>  like daemon but do the state restore at first
  kill        <cmd>   notify daemon to quit, rescan or save_and_quit
  monitor     <card>  monitor control events
  info        <card>  general information
  clean       <card>  clean application controls
  dump-state          dump the state (for all cards)
  dump-cfg            dump the configuration (expanded, for all cards)
  ```
