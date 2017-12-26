FROM alpine:3.5

RUN apk update && apk add --no-cache nginx

COPY ./start.sh /start.sh
RUN chmod u+x /start.sh && mkdir /run/nginx && chown nginx:nginx /run/nginx

EXPOSE 80

ENTRYPOINT ["/start.sh"]