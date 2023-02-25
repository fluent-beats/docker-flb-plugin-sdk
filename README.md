# Description

Docker images used to build and test `Fluent Bit` plugins.

# Requirements

* [Docker](www.docker.com)


# Provided images

## fluent-beats/fluent-bit-sdk

Provides the standard tooling required to build `Fluent Bit` and its components, including static and dynamic plugins.

This is the foundation image used to build plugins for **any** `Fluent Bit` version.

This image was tested using all `Fluent Bit` **1.8.x** versions. Please note that different `Fluent Bit` **major.minor** versions, will probably require changing this image, in order to use it to build these different versions.

## fluent-beats/fluent-bit-plugin-dev

Provides access to build plugins for **specific** `Fluent Bit` version.

This image uses a volume pointing to `/my_plugin` directory inside the container in order to access the plugin source code and generate the `.so` file.

For the `1.8.x` versions we do not recomened using versions bigger than `1.8.11`, because the `-debug` versions get bigger without any particular benefit.

> Note: the default version is `1.8.11` if not defined using **--build-arg** `FLB_VERSION`

# Multi-Stage version

The project includes a [Docker Multi-Stage Build](https://docs.docker.com/build/building/multi-stage/), that is target for `CI/CD` execution.

This version will not expose image **fluent-beats/fluent-bit-sdk**, which is useful only for local environments.

# Build images
```bash
./code/build.sh
```

# Usage
Building the official [fluent-bit plugin](https://github.com/fluent/fluent-bit-plugin) example:

```bash
git clone https://github.com/fluent/fluent-bit-plugin
cd fluent-bit-plugin
docker run --rm -ti -v $(pwd):/my_plugin fluent-beats/fluent-bit-plugin-dev \
sh -c "cmake -DFLB_SOURCE=/usr/src/fluentbit/fluent-bit-1.8.11 -DPLUGIN_NAME=out_stdout2 ../ && make"
```

And `build/flb-out_stdout2.so` will be created. It can be quickly tested with `Fluent Bit` official image:

```bash
docker run --rm -v $(pwd)/build:/my_plugin fluent/fluent-bit:1.8.11 /fluent-bit/bin/fluent-bit -e /my_plugin/flb-out_stdout2.so -i cpu -o stdout2
```
> Note: Fluent Bit doesn't provide any forward/backward compatibility, you must use the plugin in the same `Fluent Bit` version it was built.