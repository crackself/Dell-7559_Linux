### passwd + openssl生成密码
```
printf "用户名:$(openssl passwd 密码)\n" >> /etc/nginx/htpasswd
```

### nginx 启用访问加密
```
...
	location / {
        	auth_basic "Login";
	        auth_basic_user_file /etc/nginx/htpasswd;
...
	}
```

### nginx配置文件 Archlinux
`/etc/nginx/nginx.conf`
```
user http;
worker_processes auto;
worker_cpu_affinity auto;

events {
    multi_accept on;
    worker_connections 1024;
}

http {
    charset utf-8;
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    server_tokens off;
    log_not_found off;
    types_hash_max_size 4096;
    client_max_body_size 16M;

    # MIME
    include mime.types;
    default_type application/octet-stream;

    # logging
    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log warn;

    # load configs
    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*.conf;
}
```

### nginx 配置SSL
```
server {
	listen       443 ssl http2;
	listen       [::]:443 ssl http2;
#	listen       80;
	server_name  cloud.blfs.top;

        ssl_certificate "/etc/letsencrypt/live/blfs.top/fullchain.pem";
        ssl_certificate_key "/etc/letsencrypt/live/blfs.top/privkey.pem";

	ssl_ciphers "EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH";
	ssl_protocols TLSv1 TLSv1.1 TLSv1.2;

	ssl_trusted_certificate /etc/letsencrypt/live/blfs.top/chain.pem;

	location / {
        	auth_basic "Login";
	        auth_basic_user_file /etc/nginx/htpasswd;
                proxy_pass  http://localhost:5678; #端口自行修改为映射端口
                proxy_http_version	1.1;
                proxy_cache_bypass	$http_upgrade;
                proxy_set_header Upgrade           $http_upgrade;
                proxy_set_header Connection        "upgrade";
                proxy_set_header Host              $host;
                proxy_set_header X-Real-IP         $remote_addr;
                proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header X-Forwarded-Host  $host;
                proxy_set_header X-Forwarded-Port  $server_port;
	}
        location /v {
                proxy_redirect off;
                proxy_pass http://localhost:5678;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                proxy_set_header Host $http_host;
        }
	location /download {
		proxy_redirect off;
                proxy_pass http://localhost:10001;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                proxy_set_header Host $http_host;
	}
}
/etc/nginx/sites-enabled/blog.blfs.top.conf
server {
	listen       443 ssl http2;
	listen       [::]:443 ssl http2;
#	listen       80;
	server_name  blog.blfs.top;

        ssl_certificate "/etc/letsencrypt/live/blfs.top/fullchain.pem";
        ssl_certificate_key "/etc/letsencrypt/live/blfs.top/privkey.pem";

        ssl_prefer_server_ciphers on;
        add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
        ssl_ciphers 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:ECDHE-RSA-DES-CBC3-SHA:ECDHE-ECDSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:DES-CBC3-SHA:HIGH:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA';

        keepalive_timeout   70;
        ssl_session_timeout 10m;
        ssl_session_tickets on;
        ssl_stapling        on;
        ssl_stapling_verify on;
	ssl_protocols TLSv1 TLSv1.1 TLSv1.2;

	# letsencrypt免费证书验证需要指定信任到证书
	ssl_trusted_certificate /etc/letsencrypt/live/blfs.top/chain.pem;

	location /download {
                proxy_redirect off;
                proxy_pass http://localhost:10001;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                proxy_set_header Host $http_host;
	}
        location / {
                proxy_redirect off;
                proxy_pass http://localhost:5678;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                proxy_set_header Host $http_host;
        }

}
```

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
