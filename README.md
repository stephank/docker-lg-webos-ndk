# docker-lg-webos-ndk

Docker image containing a preinstalled [webosbrew/meta-lg-webos-ndk] and
[webosose/ares-cli]. These layers add about 2GB on top of [buildpack-deps].

```sh
docker run --rm -it ghcr.io/stephank/docker-lg-webos-ndk
```

Inside the container, the SDK environment is already setup, so there is no need
to source the `environment-setup` file.

This image also adds a [ccache] hook to the SDK, injecting it in `CC`, `CXX`,
and `CPP`. If you're using this image in GitHub Actions, it is recommended to
add [hendrikmuhs/ccache-action] to your workflow.

[webosbrew/meta-lg-webos-ndk]: https://github.com/webosbrew/meta-lg-webos-ndk
[webosose/ares-cli]: https://github.com/webosose/ares-cli
[buildpack-deps]: https://hub.docker.com/_/buildpack-deps
[ccache]: https://ccache.dev
[hendrikmuhs/ccache-action]: https://github.com/hendrikmuhs/ccache-action
