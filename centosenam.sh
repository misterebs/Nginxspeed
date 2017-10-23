yum update
yum install wget -y
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo rpm -Uvh epel-release-6*.rpm
yum install gcc-c++ pcre-dev pcre-devel zlib-devel make unzip vim openssl-devel
cd ~
NPS_VERSION=1.9.32.3
wget https://github.com/pagespeed/ngx_pagespeed/archive/release-${NPS_VERSION}-beta.zip
unzip release-${NPS_VERSION}-beta.zip
cd ngx_pagespeed-release-${NPS_VERSION}-beta/
wget https://dl.google.com/dl/page-speed/psol/${NPS_VERSION}.tar.gz
tar -xzvf ${NPS_VERSION}.tar.gz  # extracts to psol/
cd ~
NGINX_VERSION=1.8.0
wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
tar -xvzf nginx-${NGINX_VERSION}.tar.gz
cd nginx-${NGINX_VERSION}/
./configure \
--user=nginx                          \
--group=nginx                         \
--prefix=/etc/nginx                   \
--sbin-path=/usr/sbin/nginx           \
--conf-path=/etc/nginx/nginx.conf     \
--pid-path=/var/run/nginx.pid         \
--lock-path=/var/run/nginx.lock       \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--with-http_ssl_module                \
--with-pcre                           \
--with-file-aio                       \
--add-module=$HOME/ngx_pagespeed-release-${NPS_VERSION}-beta
make
make install
useradd -r nginx
wget -O /etc/init.d/nginx https://gist.githubusercontent.com/jimaek/8762efcc949675fe8d52/raw/b8195a71e944d46271c8a49f2717f70bcd04bf1a/gistfile1.txt
chmod +x /etc/init.d/nginx
chkconfig --add nginx
chkconfig --level 345 nginx on
rm -rf /etc/nginx/*.default
rm -rf /etc/nginx/*_temp
rm -rf /etc/nginx/html/
mkdir /etc/nginx/conf.d
service nginx restart
