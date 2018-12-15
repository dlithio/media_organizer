FROM ubuntu:18.04

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl mediainfo imagemagick && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# https://github.com/boxboat/fixuid
RUN addgroup --gid 1000 docker && \
    adduser --uid 1000 --ingroup docker --home /home/docker --shell /bin/sh --disabled-password --gecos "" docker
RUN USER=docker && \
    GROUP=docker && \
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.4/fixuid-0.4-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml
USER docker:docker
ENTRYPOINT ["fixuid"]
