#!/bin/sh

set -e
cd $(dirname $0)

docker build -f Dockerfile.sdk -t etriphany/fluent-bit-sdk .
docker build -f Dockerfile.flb -t etriphany/fluent-bit-plugin-dev --build-arg FLB_VERSION=1.8.4 .
