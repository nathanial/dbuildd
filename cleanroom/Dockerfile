FROM debian:jessie

ENV DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical DEBCONF_NOWARNINGS=yes

RUN apt-get update && \
    packages="devscripts git-buildpackage" && \
    for i in $(seq 3); do \
      echo "attempt $i to download packages..."; \
      apt-get install --assume-yes --download-only $packages && break; \
    done && \
    apt-get install --yes $packages

RUN apt-get install --yes php5-cli php5-curl unzip npm nodejs-legacy bundler \
						apache2-dev fontconfig-config fonts-dejavu-core libapr1 libapr1-dev \
						libaprutil1 libaprutil1-dev libexpat1-dev libfontconfig1 libfreetype6 \
  					libldap2-dev libpng12-0 libsctp-dev libsctp1 php5-xdebug uuid-dev

RUN mkdir /usr/src/placelocal
WORKDIR /usr/src/placelocal

ADD package.json /usr/src/placelocal/package.json
ADD Gemfile /usr/src/placelocal/Gemfile

RUN bundle
RUN npm install

COPY cleanroom apt-retry-download /usr/bin/
WORKDIR /usr/src
