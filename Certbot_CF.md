### Manual update Free certificate from letsencrypt for Cloudflare
preset cloudfalre API and account in /etc/letsencrypt/cf.ini
install python3-certbot-dns-cloudflare

# cloudflare 泛域名
```
certbot certonly  -d *.domain --dns-cloudflare-credentials /etc/letsencrypt/cf.ini --manual --preferred-challenges dns-01  --server https://acme-v02.api.letsencrypt.org/directory
```
# 普通单域名
```
certbot certonly --webroot --agree-tos -v -t --email crackself@gmail.com -w /usr/share/nginx/ -d domain
certbot renew (自动续期)
```
