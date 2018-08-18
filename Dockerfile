FROM ubuntu:trusty
MAINTAINER dezinger@gmail.com

ENV DEBIAN_FRONTEND noninteractive

COPY files/ /

RUN \
# update & install base util
    apt-get -y update && apt-get -y upgrade && \
    apt-get -o Dpkg::Options::=--force-confdef -y install \ 
    supervisor curl wget locales gettext-base cron mc \ 
    python-software-properties software-properties-common && \
# setup locale
    locale-gen en_US.UTF-8 ru_RU.UTF-8 && \
# prepeare folders
    mkdir --mode 777 -p /var/log/supervisor && \
    chmod -R 777 /var/run /var/log /etc/passwd /etc/group && \
    mkdir --mode 777 -p /tmp/sockets && \
# clean 
    apt-get -y autoremove && apt-get -y clean && apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog

ENV \
    LC_ALL=ru_RU.UTF-8 \
    LANG=ru_RU.UTF-8 \
    LANGUAGE=ru_RU.UTF-8

ENTRYPOINT ["/bin/bash", "-e", "/init/entrypoint"]

CMD ["run"]