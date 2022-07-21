### Manual update Free certificate from letsencrypt for Cloudflare
```
certbot certonly  -d "*.DOMIAN" --manual --preferred-challenges dns-01  --server https://acme-v02.api.letsencrypt.org/directory
```
