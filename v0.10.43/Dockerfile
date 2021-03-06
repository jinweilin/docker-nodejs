FROM ubuntu:14.04
MAINTAINER jinwei.lin@gmail.com

ENV NODE_VERSION 0.10.43
ENV NPM_VERSION 2.14.22

RUN cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
    echo 'Asia/Taipei' > /etc/timezone && date && \
    sed -e 's;UTC=yes;UTC=no;' -i /etc/default/rcS && \
    apt-get update && \
    apt-get install -y curl && \
    set -ex && \
    for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
    done

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" && \
	curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" && \
	gpg --verify SHASUMS256.txt.asc && \
	grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - && \
	tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 && \
	rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc && \
	adduser --disabled-login --gecos 'NodeJS' nodejs && \
	npm install -g npm@"$NPM_VERSION" && \
 	npm install -g express-generator nodemon && \
	npm cache clear && \
  echo "!/bin/sh ntpdate ntp.ubuntu.com" >> /etc/cron.daily/ntpdate && \
  chmod 750 /etc/cron.daily/ntpdate && \
  apt-get clean

ADD scripts /scripts
ADD start /start
RUN chmod 755 /start

ENTRYPOINT ["/start"]
