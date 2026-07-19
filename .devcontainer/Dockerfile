FROM debian:stable

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    live-build \
    debootstrap \
    squashfs-tools \
    xorriso \
    fakeroot \
    build-essential \
    curl \
    wget \
    git \
    sudo \
    shellcheck \
    lintian \
    devscripts \
    jq \
    make \
    && rm -rf /var/lib/apt/lists/*

# Add a non-root user
RUN useradd -m -s /bin/bash mcc-dev && \
    echo "mcc-dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER mcc-dev
WORKDIR /workspace
