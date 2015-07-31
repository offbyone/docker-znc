# version 1.6-1
# docker-version 1.5.0
FROM        ubuntu:14.04
MAINTAINER  Chris Rose "offline@offby1.net"

# We use a bootstrap script to avoid having temporary cache files and build
# dependencies being committed and included into the docker image.
RUN         apt-get update && apt-get install -y \
              sudo wget build-essential libssl-dev libperl-dev pkg-config \
              python3-dev python3 python-software-properties
ADD         bootstrap.sh user-setup /tmp/
RUN         chmod +x /tmp/bootstrap.sh /tmp/user-setup && sync; /tmp/bootstrap.sh

RUN         /tmp/user-setup
ADD         start-znc /usr/local/bin/
ADD         znc.conf.default /src/
RUN         chmod 644 /src/znc.conf.default

EXPOSE      6667
ENTRYPOINT  ["/usr/local/bin/start-znc"]
CMD         [""]
