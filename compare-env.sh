#!/bin/sh

# Builds up to the sdk-install stage of the Dockerfile, then compares
# environment variables before and after running the environment-setup script.
# This is used to generate the ENV instructions at the end of the Dockerfile.

set -xe

IMAGE_NAME=local.invalid/docker-lg-webos-ndk-compare-env
docker build -t $IMAGE_NAME --target sdk-install .
docker run --rm -i $IMAGE_NAME bash << EOF

env | sort > before
source /opt/webos-sdk-x86_64/*/environment-setup-armv7a-neon-webos-linux-gnueabi
env | sort > after

echo
echo "## Docker instructions"
comm -13 before after | sed -e 's/^\([^=]*\)=\(.*\)$/ENV \1="\2"/g'

EOF
