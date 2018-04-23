# version 1.6.6
# docker-version 1.11.2
FROM alpine:latest
MAINTAINER Danny Al-Gaaf "danny.al-gaaf@bisect.de"

ENV ZNC_VERSION 1.6.6

RUN apk add --no-cache sudo bash autoconf automake gettext-dev make g++ \
        openssl-dev pkgconfig perl-dev swig zlib-dev ca-certificates \
    && mkdir -p /src \
    && cd /src \
    && wget "http://znc.in/releases/archive/znc-${ZNC_VERSION}.tar.gz" \
    && tar -zxf "znc-${ZNC_VERSION}.tar.gz" \
    && cd "znc-${ZNC_VERSION}" \
    && ./configure --disable-ipv6 \
    && make \
    && make install \
    && rm -rf /src /var/cache/apk/*

RUN adduser -S znc
RUN addgroup -S znc
ADD docker-entrypoint.sh /entrypoint.sh
ADD znc.conf.default /znc.conf.default
RUN chmod 644 /znc.conf.default

VOLUME /znc-data

EXPOSE 6667
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
