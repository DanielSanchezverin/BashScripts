#!/bin/bash
  
sudo add-apt-repository ppa:maxmind/ppa
sudo apt update
sudo apt install libmaxminddb0 libmaxminddb-dev mmdb-bin
sudo git clone --depth=1 https://github.com/leev/ngx_http_geoip2_module.git /root/ngx_http_geoip2_module/
sudo wget -P /usr/local/src/ https://nginx.org/download/nginx-1.19.0.tar.gz
sudo tar zxvf /usr/local/src/nginx-1.19.0.tar.gz -C /usr/local/src/
sudo wget -P /usr/local/src/ https://ftp.pcre.org/pub/pcre/pcre-8.44.tar.gz
sudo tar xzvf /usr/local/src/pcre-8.44.tar.gz -C /usr/local/src/
sudo wget -P /usr/local/src/ https://www.zlib.net/zlib-1.2.11.tar.gz
sudo tar xzvf /usr/local/src/zlib-1.2.11.tar.gz -C /usr/local/src/
sudo wget -P /usr/local/src/ https://www.openssl.org/source/openssl-1.1.1g.tar.gz
sudo tar xzvf /usr/local/src/openssl-1.1.1g.tar.gz -C /usr/local/src/
sudo rm /usr/local/src/*.tar.gz
cd /usr/local/src/nginx-1.19.0/

sudo sh /usr/local/src/nginx-1.19.0/configure --sbin-path=/usr/sbin/nginx --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-pcre-jit --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_gzip_static_module --add-dynamic-module=/root/ngx_http_geoip2_module --with-openssl=/usr/local/src/openssl-1.1.1g

sudo make

sudo make install