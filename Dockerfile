# ffmpeg - http://ffmpeg.org/download.html
#
# https://hub.docker.com/r/jrottenberg/ffmpeg/
#
#

FROM       registry.cn-hangzhou.aliyuncs.com/0x01301c74/php-fpm-slim AS base

RUN     apk  add --no-cache --update libgcc libstdc++ ca-certificates libcrypto1.0 libssl1.0 libgomp expat

ARG        PKG_CONFIG_PATH=/opt/ffmpeg/lib/pkgconfig

ARG        LD_LIBRARY_PATH=/opt/ffmpeg/lib
ARG        PREFIX=/opt/ffmpeg
ARG        MAKEFLAGS="-j2"

ENV         FFMPEG_VERSION=3.4.1     \
            FDKAAC_VERSION=0.1.5      \
            LAME_VERSION=3.99.5       \
            LIBASS_VERSION=0.13.7     \  
            OGG_VERSION=1.3.2         \
            OPENCOREAMR_VERSION=0.1.4 \
            OPUS_VERSION=1.2          \
            OPENJPEG_VERSION=2.1.2    \
            THEORA_VERSION=1.1.1      \
            VORBIS_VERSION=1.3.5      \
            VPX_VERSION=1.6.1         \
            X264_VERSION=20170226-2245-stable \
            X265_VERSION=2.3          \
            XVID_VERSION=1.3.4        \
            FREETYPE_VERSION=2.5.5    \
            FRIBIDI_VERSION=0.19.7    \
            FONTCONFIG_VERSION=2.12.4 \
            LIBVIDSTAB_VERSION=1.1.0  \
            SRC=/usr/local

ARG         OGG_SHA256SUM="e19ee34711d7af328cb26287f4137e70630e7261b17cbe3cd41011d73a654692  libogg-1.3.2.tar.gz"
ARG         OPUS_SHA256SUM="77db45a87b51578fbc49555ef1b10926179861d854eb2613207dc79d9ec0a9a9  opus-1.2.tar.gz"
ARG         VORBIS_SHA256SUM="6efbcecdd3e5dfbf090341b485da9d176eb250d893e3eb378c428a2db38301ce  libvorbis-1.3.5.tar.gz"
ARG         THEORA_SHA256SUM="40952956c47811928d1e7922cda3bc1f427eb75680c3c37249c91e949054916b  libtheora-1.1.1.tar.gz"
ARG         XVID_SHA256SUM="4e9fd62728885855bc5007fe1be58df42e5e274497591fec37249e1052ae316f  xvidcore-1.3.4.tar.gz"
ARG         FREETYPE_SHA256SUM="5d03dd76c2171a7601e9ce10551d52d4471cf92cd205948e60289251daddffa8  freetype-2.5.5.tar.gz"
ARG         LIBVIDSTAB_SHA256SUM="14d2a053e56edad4f397be0cb3ef8eb1ec3150404ce99a426c4eb641861dc0bb  v1.1.0.tar.gz"
ARG         LIBASS_SHA256SUM="8fadf294bf701300d4605e6f1d92929304187fca4b8d8a47889315526adbafd7  0.13.7.tar.gz"
ARG         FRIBIDI_SHA256SUM="3fc96fa9473bd31dcb5500bdf1aa78b337ba13eb8c301e7c28923fea982453a8  0.19.7.tar.gz"

COPY ./install.sh /tmp/build/install-ffmpeg.sh

RUN apk add --no-cache --update autoconf \
    automake bash binutils bzip2 cmake curl coreutils \
    file g++ gcc gperf libtool make python openssl-dev tar yasm zlib-dev expat-dev \
    && cd /tmp/build && chmod +x install-ffmpeg.sh && ./install-ffmpeg.sh \
    && rm -fr /tmp/src \
    && rm -fr /var/cache/apk/*

COPY --from=base /usr/local /usr/local
