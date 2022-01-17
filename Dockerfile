FROM buildpack-deps
RUN set -x \
  && cd /tmp \
  && curl -fsSL -o installer.sh "https://github.com/webosbrew/meta-lg-webos-ndk/releases/download/1.0.g-rev.5/webos-sdk-x86_64-armv7a-neon-toolchain-1.0.g.sh" \
  && echo "d07f7c5a2c8532ea0ab486509a0a4c8dc10a117a32a3de4169e52fa8a90d8be6 *installer.sh" | sha256sum -c - \
  && chmod a+x installer.sh \
  && ./installer.sh -y \
  && rm installer.sh
