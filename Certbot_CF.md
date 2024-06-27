### Manual update Free certificate from letsencrypt for Cloudflare

## Ⅰ、 acme.sh （Recommend）
#### 参考：
- https://github.com/acmesh-official/acme.sh/wiki/%E8%AF%B4%E6%98%8E
- https://github.com/acmesh-official/acme.sh/wiki/dnsapi#dns_cf
#### 安装acme.sh, 目录在~/.acme.sh/
`curl https://get.acme.sh | sh -s email=xxx@gmail.com`

#### 通过cloudflare DNS api获取证书
```
export CF_Key="fc7***7ef83***ba062” # Global API Key
export CF_Email="xxx@gmail.com“
```
#### 申请证书，会自动添加dns txt到cloudflare 解析记录
`./acme.sh --issue --dns dns_cf -d blfs.eu.org -d '*.blfs.eu.org'`
#### 成功后安装证书到指定目录
```
acme.sh --install-cert -d blfs.eu.org \
--key-file       /etc/nginx/ssl/key.pem  \
--fullchain-file /etc/nginx/ssl/cert.pem
```
#### 重启Nginx
`systemctl restart nginx`
#### 或重载Nginx
`service nginx force-reload`

## Ⅱ、 certbot
preset cloudfalre API and account in /etc/letsencrypt/cf.ini
install python3-certbot-dns-cloudflare
#### cloudflare 泛域名
```
certbot certonly  -d *.domain --dns-cloudflare-credentials /etc/letsencrypt/cf.ini --manual --preferred-challenges dns-01  --server https://acme-v02.api.letsencrypt.org/directory
```
#### 普通单域名
```
certbot certonly --webroot --agree-tos -v -t --email crackself@gmail.com -w /usr/share/nginx/ -d domain
certbot renew (自动续期)
```
