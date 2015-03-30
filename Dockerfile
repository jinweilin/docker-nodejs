FROM sameersbn/ubuntu:14.04.20150323
MAINTAINER sameer@damagehead.com

RUN cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
    echo 'Asia/Taipei' > /etc/timezone && date
RUN sed -e 's;UTC=yes;UTC=no;' -i /etc/default/rcS

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv C7917B12 \
 && echo "deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu trusty main" >> /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y nodejs \
 && adduser --disabled-login --gecos 'NodeJS' nodejs \
 && npm install -g express-generator nodemon \
 && rm -rf /var/lib/apt/lists/* # 20150323

RUN echo "!/bin/sh ntpdate ntp.ubuntu.com" >> /etc/cron.daily/ntpdate \
    && chmod 750 /etc/cron.daily/ntpdate

ADD scripts /scripts
ADD start /start
RUN chmod 755 /start

ENTRYPOINT ["/start"]
