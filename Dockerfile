FROM golang:alpine AS builder

ARG VERSION

RUN set -ex && cd / \
    && wget -O - "https://github.com/SagerNet/wgsocks/archive/$VERSION.tar.gz" | tar xzf -
RUN set -ex && cd /wgsocks-*/ \
    && go build -v -o /usr/bin/wgsocks


FROM alpine:latest

LABEL org.opencontainers.image.authors "Fei Yang <projects@feiyang.moe>"
LABEL org.opencontainers.image.url https://dev.azure.com/fei1yang/containers
LABEL org.opencontainers.image.documentation https://dev.azure.com/fei1yang/containers/_git/wgsocks?path=/README.md
LABEL org.opencontainers.image.source https://dev.azure.com/fei1yang/containers/_git/wgsocks
LABEL org.opencontainers.image.vendor "FeiYang Labs"
LABEL org.opencontainers.image.licenses GPL-3.0-only
LABEL org.opencontainers.image.title wgsocks
LABEL org.opencontainers.image.description "Minimalistic wireguard to socks5 wrapper container image based on Apline linux."

COPY --from=builder /usr/bin/wgsocks /usr/bin/wgsocks

VOLUME ["/config"]

WORKDIR /config

CMD ["/usr/bin/wgsocks"]
