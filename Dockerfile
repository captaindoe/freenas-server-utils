FROM alpine:latest
MAINTAINER Mojolicious

COPY cpanfile /
ENV EV_EXTRA_DEFS -DEV_NO_ATFORK

RUN apk update && \
      apk add perl perl-io-socket-ssl perl-dbd-pg perl-dev g++ make wget curl && \
      curl -L https://cpanmin.us | perl - App::cpanminus && \
      cpanm --installdeps . -M https://cpan.metacpan.org && \
      apk del perl-dev g++ make wget curl && \
      rm -rf /root/.cpanm/* /usr/local/share/man/*

