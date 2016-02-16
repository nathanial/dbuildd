FROM debian:jessie

ENV DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical DEBCONF_NOWARNINGS=yes

RUN apt-get update && \
    packages="devscripts git-buildpackage" && \
    for i in $(seq 3); do \
      echo "attempt $i to download packages..."; \
      apt-get install --assume-yes --download-only $packages && break; \
    done && \
    apt-get install --yes $packages

COPY cleanroom apt-retry-download /usr/bin/
ENTRYPOINT ["/usr/bin/cleanroom"]
WORKDIR /usr/src
