#!/bin/sh

RTDSLUG=$1
RTDADDRESS=$2

rm -rf /etc/nginx/conf.d/*
cat << EOF > /etc/nginx/conf.d/rtd-proxy.conf

server {
    listen 80;

    location / {
        proxy_pass https://${RTDADDRESS}:443;
        proxy_set_header Host \$http_host;
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Real_IP \$remote_addr;
        proxy_set_header X-Scheme \$scheme;
        proxy_set_header X-RTD-SLUG ${RTDSLUG};
        proxy_connect_timeout 10s;
        proxy_read_timeout 20s;
    }

}

EOF

exec /usr/sbin/nginx -g 'daemon off;'
