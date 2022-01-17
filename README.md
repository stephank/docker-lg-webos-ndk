# docker-lg-webos-ndk

Docker image containing a preinstalled [webosbrew/meta-lg-webos-ndk] and
[webosose/ares-cli]. These layers add about 2GB on top of [buildpack-deps].

```sh
docker run --rm -it ghcr.io/stephank/docker-lg-webos-ndk
```

Inside the container, you still need to setup the NDK environment:

```sh
source /opt/webos-sdk-x86_64/1.0.g/environment-setup-armv7a-neon-webos-linux-gnueabi
```

You can, of course, also use this image as the base layer in your own
Dockerfile using `FROM`. However, the same applies: in each `RUN`, you will
have to source the environment setup script to do webOS builds.

[webosbrew/meta-lg-webos-ndk]: https://github.com/webosbrew/meta-lg-webos-ndk
[webosose/ares-cli]: https://github.com/webosose/ares-cli
[buildpack-deps]: https://hub.docker.com/_/buildpack-deps
