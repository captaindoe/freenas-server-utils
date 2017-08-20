FROM alpine:latest

COPY setup.pl /

ENV EV_EXTRA_DEFS -DEV_NO_ATFORK

RUN apk update \
    && apk add perl perl-io-socket-ssl perl-dbd-pg perl-dev g++ make wget curl \
    && apk add git unzip openvpn \
    && perl setup.pl \
    && apk del perl-dev g++ make wget \
    && rm -rf /root/.cpanm/* /usr/local/share/man/*

