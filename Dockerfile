FROM debian:jessie

RUN apt-get update && apt-get install -y wget

RUN wget https://github.com/jwilder/dockerize/releases/download/v0.2.0/dockerize-linux-amd64-v0.2.0.tar.gz &&\
    tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.2.0.tar.gz &&\
    rm dockerize-linux-amd64-v0.2.0.tar.gz && \
    chown root /usr/local/bin/dockerize

RUN wget http://get.influxdb.org/telegraf/telegraf_0.10.2-1_amd64.deb &&\
    dpkg -i telegraf_0.10.2-1_amd64.deb &&\
    rm telegraf_0.10.2-1_amd64.deb

VOLUME /rootfs/sys
VOLUME /rootfs/proc
VOLUME /var/run/docker.sock

ENV INFLUXDB_HOSTNAME 127.0.0.1:8086
ENV INFLUXDB_DATABASE telegraf
ENV INFLUXDB_PASSWORD ""
ENV INFLUXDB_USERNAME ""
ENV HOST_PROC /rootfs/proc
ENV HOST_SYS /rootfs/sys

ADD telegraf.conf /config/telegraf.conf
CMD sh
#CMD /usr/bin/telegraf --config=/etc/telegraf/telegraf.conf
#ENTRYPOINT /usr/local/bin/dockerize -template /config/telegraf.conf:/etc/telegraf/telegraf.conf
CMD /usr/local/bin/dockerize -template /config/telegraf.conf:/etc/telegraf/telegraf.conf /usr/bin/telegraf --config=/etc/telegraf/telegraf.conf