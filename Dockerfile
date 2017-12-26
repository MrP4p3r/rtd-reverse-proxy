FROM alpine:3.5

RUN apk update && apk add --no-cache nginx

COPY ./start.sh /start.sh

EXPOSE 80

ENTRYPOINT ["/start.sh"]