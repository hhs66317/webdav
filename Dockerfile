FROM alpine

ENV USERNAME="" PASSWORD=""

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /

RUN apk update \
    && apk add --no-cache nginx nginx-mod-http-dav-ext nginx-mod-http-fancyindex nginx-mod-http-headers-more openssl curl \
    && mkdir /run/nginx \
    && mkdir /data \
    && chmod +x /entrypoint.sh \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

VOLUME /data

EXPOSE 80
EXPOSE 443

CMD /entrypoint.sh && /usr/sbin/nginx -g "daemon off;"
