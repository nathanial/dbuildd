FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

RUN apt-get update && \
    for i in $(seq 3); do \
      echo "attempt $i to download packages..."; \
      apt-get install --assume-yes --download-only devscripts && break; \
    done && \
    apt-get install --yes devscripts

COPY cleanroom apt-retry-download /usr/bin/
ENTRYPOINT ["/usr/bin/cleanroom"]
WORKDIR /usr/src
