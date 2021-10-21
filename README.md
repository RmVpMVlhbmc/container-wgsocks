## wgsocks

### Overview

Minimalistic wireguard to socks5 wrapper container image based on Apline linux.

### Build

```
ARGS=()
for i in $(find ./VERSIONS/ -type f); do
  ARGS+=('--build-arg' "${i##*/}=$(< $i)")
done
docker build "${ARGS[@]}" --tag ${PWD##*/} \
       --label org.opencontainers.image.created="$(date --rfc-3339 seconds --utc)" \
       --label org.opencontainers.image.version=$(< DISPLAY_VERSION) \
       --label org.opencontainers.image.revision=$(git rev-parse HEAD) .
```

Push image to registry:

```
docker tag ${PWD##*/} $CONTAINER_REGISTRY_USERNAME/${PWD##*/}:$(< DISPLAY_VERSION)
docker tag ${PWD##*/} $CONTAINER_REGISTRY_USERNAME/${PWD##*/}:latest
docker push --all-tags $CONTAINER_REGISTRY_USERNAME/${PWD##*/}
```

### Environment variables

**None**

### Run

```
docker run --detach \
       --restart always \
       --volume $PATH_TO_CONFIG:/config \
       fei1yang/wgsocks:latest wgsocks -a $LOCAL_ADDR -b $SOCKS5_BIND_ADDR
```
The code used in SagerNet for configuration file generation is [here](https://github.com/SagerNet/SagerNet/blob/22489c20d7b2d4db7960d0044303597488fac6f1/app/src/main/java/io/nekohasekai/sagernet/fmt/wireguard/WireGuardFmt.kt#L27-L41).

Note: [Podman](https://podman.io/) is recommended for use this container image due to its amazing automatic update feature, please refer to the [official document](https://docs.podman.io/en/latest/markdown/podman-auto-update.1.html) for further details.
