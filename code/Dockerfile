FROM    debian:stretch AS flb_sdk

ENV     DEBIAN_FRONTEND noninteractive
ENV     PACKAGES "build-essential cmake make curl unzip libssl1.0-dev libasl-dev libsasl2-dev pkg-config libsystemd-dev zlib1g-dev flex ca-certificates bison"

# Build packages
RUN     apt-get update && \
        apt-get install -y --no-install-recommends ${PACKAGES} && \
        rm -rf /var/lib/apt/lists/*

#########

FROM    flb_sdk

LABEL   org.opencontainers.image.authors="etriphany.com"

ARG     FLB_VERSION=1.8.11

# Donwload and extract
WORKDIR /usr/src/fluentbit
RUN     curl -Lo /tmp/fluentbit.tgz https://github.com/fluent/fluent-bit/archive/v${FLB_VERSION}.tar.gz && \
        tar xf /tmp/fluentbit.tgz

# Build (starting from v1.8.5 we must fix the missing 'ares_build.h')
WORKDIR /usr/src/fluentbit/fluent-bit-${FLB_VERSION}
RUN     cp lib/c-ares-*/include/ares_build.h.dist include/ares_build.h && \
        cmake .

WORKDIR /my_plugin/build