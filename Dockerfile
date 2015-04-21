# version 1.6-1
# docker-version 1.5.0
FROM        ubuntu:14.04
MAINTAINER  Chris Rose "offline@offby1.net"

# We use a bootstrap script to avoid having temporary cache files and build
# dependencies being committed and included into the docker image.
RUN         apt-get update && apt-get install -y \
              sudo wget build-essential libssl-dev libperl-dev libpython-dev pkg-config
ADD         bootstrap.sh /tmp/
RUN         chmod +x /tmp/bootstrap.sh && sync; /tmp/bootstrap.sh

RUN         useradd znc
ADD         start-znc /usr/local/bin/
ADD         znc.conf.default /src/
RUN         chmod 644 /src/znc.conf.default

EXPOSE      6667
ENTRYPOINT  ["/usr/local/bin/start-znc"]
CMD         [""]
