# Description

Docker images used to build and test fluent-bit plugins.

# Requirements

* [Docker](www.docker.com)


# Provided images
## fluent-beats/fluent-bit-sdk

Provides the standard tooling required to build fluent-bit and its components, including static and dynamic plugins.
This is the foundation image used to build plugins for any fluent-bit version.

## fluent-beats/fluent-bit-plugin-dev

Provides access to build plugins for specific fluent-bit version.
This image uses a volume pointing to `/my_plugin` directory inside the container in order to access the plugin source code and generate the `.so` file.

# Build images
```bash
./code/build.sh
```

# Usage
Building the official [fluent-bit plugin](https://github.com/fluent/fluent-bit-plugin) example:

```bash
git clone https://github.com/fluent/fluent-bit-plugin
cd fluent-bit-plugin
docker run --rm -ti -v $(pwd):/my_plugin fluent-beats/fluent-bit-plugin-dev cmake -DFLB_SOURCE=/usr/src/fluentbit/fluent-bit-1.8.4 -DPLUGIN_NAME=out_stdout2 ../
docker run --rm -ti -v $(pwd):/my_plugin fluent-beats/fluent-bit-plugin-dev make
```

And `build/flb-out_stdout2.so` will be created. It can be quickly tested with fluent-bit official image:

```
docker run --rm -v $(pwd)/build:/my_plugin fluent/fluent-bit:1.8.4 /fluent-bit/bin/fluent-bit -e /my_plugin/flb-out_stdout2.so -i cpu -o stdout2
```
