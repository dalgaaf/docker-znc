# version 1.6.4-1
# docker-version 1.11.2
FROM debian:sid
MAINTAINER Danny Al-Gaaf "danny.al-gaaf@bisect.de"

RUN apt-get update \
    && apt-get install -y sudo wget build-essential libssl-dev libperl-dev \
               pkg-config swig3.0 libicu-dev ca-certificates znc znc-python \
               znc-perl znc-dev \
    && apt-get remove -y wget \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd znc
ADD docker-entrypoint.sh /entrypoint.sh
ADD znc.conf.default /znc.conf.default
RUN chmod 644 /znc.conf.default

VOLUME /znc-data

EXPOSE 6667
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
