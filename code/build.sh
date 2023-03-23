#!/bin/sh

set -e
cd $(dirname $0)

docker build -f Dockerfile.sdk -t fluent-beats/fluent-bit-sdk .
docker build -f Dockerfile.flb -t fluent-beats/fluent-bit-plugin-dev --build-arg FLB_VERSION=1.8.11 .
