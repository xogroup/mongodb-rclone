FROM alpine:3.6
MAINTAINER Core Services <coreservices.group@xogrp.com>
LABEL Description="Docker Image based of Alpine 3.6 with MongoDB and Google RClone"

USER root
ENV RCLONE_VERSION=v1.40

RUN apk update \
&& apk upgrade \
&& apk add coreutils mongodb-tools wget ca-certificates \
&& cd /tmp \
&& wget -q https://downloads.rclone.org/$RCLONE_VERSION/rclone-$RCLONE_VERSION-linux-amd64.zip \
&& unzip /tmp/rclone-$RCLONE_VERSION-linux-amd64.zip \
&& cp /tmp/rclone-$RCLONE_VERSION-linux-amd64/rclone /usr/bin \
&& chown root:root /usr/bin/rclone \
&& chmod 755 /usr/bin/rclone \
&& touch /var/log/cron.log \
&& rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

COPY rclone.conf /root/.config/rclone/rclone.conf

CMD ["/usr/sbin/crond", "-f", "-d", "0"]
