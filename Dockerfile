FROM buildpack-deps AS sdk-install

# Install the SDK.
RUN set -x \
  && cd /tmp \
  && curl -fsSL -o installer.sh "https://github.com/webosbrew/meta-lg-webos-ndk/releases/download/1.0.g-rev.5/webos-sdk-x86_64-armv7a-neon-toolchain-1.0.g.sh" \
  && echo "d07f7c5a2c8532ea0ab486509a0a4c8dc10a117a32a3de4169e52fa8a90d8be6 *installer.sh" | sha256sum -c - \
  && chmod a+x installer.sh \
  && ./installer.sh -y \
  && rm installer.sh

# Environment additions.
COPY ./environment-setup.d/ /opt/webos-sdk-x86_64/1.0.g/sysroots/x86_64-webossdk-linux/environment-setup.d/

# Start a new stage here so we can use the sdk-install stage in compare-env.sh.
FROM sdk-install AS final

# Additional Debian packages.
RUN set -x \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    # For use with hendrikmuhs/ccache-action
    ccache \
    # For ares-cli
    nodejs npm \
  && rm -rf /var/lib/apt/lists/*

# Install ares-cli.
RUN set -x \
  && npm install -g @webosose/ares-cli \
  && rm -rf /root/.npm

# These are generated using compare-env.sh.
ENV AR="arm-webos-linux-gnueabi-ar"
ENV ARCH="arm"
ENV AS="arm-webos-linux-gnueabi-as "
ENV CC="ccache arm-webos-linux-gnueabi-gcc  -march=armv7-a -mfpu=neon  -mfloat-abi=softfp --sysroot=/opt/webos-sdk-x86_64/1.0.g/sysroots/armv7a-neon-webos-linux-gnueabi"
ENV CCACHE_PATH="/opt/webos-sdk-x86_64/1.0.g/sysroots/x86_64-webossdk-linux/usr/bin:/opt/webos-sdk-x86_64/1.0.g/sysroots/x86_64-webossdk-linux/usr/bin/../x86_64-webossdk-linux/bin:/opt/webos-sdk-x86_64/1.0.g/sysroots/x86_64-webossdk-linux/usr/bin/arm-webos-linux-gnueabi:/opt/webos-sdk-x86_64/1.0.g/sysroots/x86_64-webossdk-linux/usr/bin/arm-webos-linux-uclibc:/opt/webos-sdk-x86_64/1.0.g/sysroots/x86_64-webossdk-linux/usr/bin/arm-webos-linux-musl:"
ENV CFLAGS=" -O2 -pipe -g -feliminate-unused-debug-types "
ENV CONFIGURE_FLAGS="--target=arm-webos-linux-gnueabi --host=arm-webos-linux-gnueabi --build=x86_64-linux --with-libtool-sysroot=/opt/webos-sdk-x86_64/1.0.g/sysroots/armv7a-neon-webos-linux-gnueabi"
ENV CONFIG_SITE="/opt/webos-sdk-x86_64/1.0.g/site-config-armv7a-neon-webos-linux-gnueabi"
ENV CPP="ccache arm-webos-linux-gnueabi-gcc -E  -march=armv7-a -mfpu=neon  -mfloat-abi=softfp --sysroot=/opt/webos-sdk-x86_64/1.0.g/sysroots/armv7a-neon-webos-linux-gnueabi"
ENV CPPFLAGS=""
ENV CROSS_COMPILE="arm-webos-linux-gnueabi-"
ENV CXX="ccache arm-webos-linux-gnueabi-g++  -march=armv7-a -mfpu=neon  -mfloat-abi=softfp --sysroot=/opt/webos-sdk-x86_64/1.0.g/sysroots/armv7a-neon-webos-linux-gnueabi"
ENV CXXFLAGS=" -O2 -pipe -g -feliminate-unused-debug-types "
ENV GDB="arm-webos-linux-gnueabi-gdb"
ENV KCFLAGS="--sysroot=/opt/webos-sdk-x86_64/1.0.g/sysroots/armv7a-neon-webos-linux-gnueabi"
ENV LD="arm-webos-linux-gnueabi-ld  --sysroot=/opt/webos-sdk-x86_64/1.0.g/sysroots/armv7a-neon-webos-linux-gnueabi"
ENV LDFLAGS="-Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed"
ENV M4="m4"
ENV NM="arm-webos-linux-gnueabi-nm"
ENV OBJCOPY="arm-webos-linux-gnueabi-objcopy"
ENV OBJDUMP="arm-webos-linux-gnueabi-objdump"
ENV OECORE_ACLOCAL_OPTS="-I /opt/webos-sdk-x86_64/1.0.g/sysroots/x86_64-webossdk-linux/usr/share/aclocal"
ENV OECORE_DISTRO_VERSION="1.0.g"
ENV OECORE_NATIVE_SYSROOT="/opt/webos-sdk-x86_64/1.0.g/sysroots/x86_64-webossdk-linux"
ENV OECORE_SDK_VERSION="1.0.g"
ENV OECORE_TARGET_SYSROOT="/opt/webos-sdk-x86_64/1.0.g/sysroots/armv7a-neon-webos-linux-gnueabi"
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/webos-sdk-x86_64/1.0.g/sysroots/x86_64-webossdk-linux/usr/bin:/opt/webos-sdk-x86_64/1.0.g/sysroots/x86_64-webossdk-linux/usr/sbin:/opt/webos-sdk-x86_64/1.0.g/sysroots/x86_64-webossdk-linux/bin:/opt/webos-sdk-x86_64/1.0.g/sysroots/x86_64-webossdk-linux/sbin:/opt/webos-sdk-x86_64/1.0.g/sysroots/x86_64-webossdk-linux/usr/bin/../x86_64-webossdk-linux/bin:/opt/webos-sdk-x86_64/1.0.g/sysroots/x86_64-webossdk-linux/usr/bin/arm-webos-linux-gnueabi:/opt/webos-sdk-x86_64/1.0.g/sysroots/x86_64-webossdk-linux/usr/bin/arm-webos-linux-uclibc:/opt/webos-sdk-x86_64/1.0.g/sysroots/x86_64-webossdk-linux/usr/bin/arm-webos-linux-musl"
ENV PKG_CONFIG_PATH="/opt/webos-sdk-x86_64/1.0.g/sysroots/armv7a-neon-webos-linux-gnueabi/usr/lib/pkgconfig:/opt/webos-sdk-x86_64/1.0.g/sysroots/armv7a-neon-webos-linux-gnueabi/usr/share/pkgconfig"
ENV PKG_CONFIG_SYSROOT_DIR="/opt/webos-sdk-x86_64/1.0.g/sysroots/armv7a-neon-webos-linux-gnueabi"
ENV RANLIB="arm-webos-linux-gnueabi-ranlib"
ENV SDKTARGETSYSROOT="/opt/webos-sdk-x86_64/1.0.g/sysroots/armv7a-neon-webos-linux-gnueabi"
ENV STRIP="arm-webos-linux-gnueabi-strip"
ENV TARGET_PREFIX="arm-webos-linux-gnueabi-"
