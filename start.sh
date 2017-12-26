#!/bin/sh

RTDSLUG=$1
RTDADDRESS=$2

cat << EOF > /etc/nginx/conf.d/

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
