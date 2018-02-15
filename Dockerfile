FROM alpine:3.7
MAINTAINER PaladinTyrion <paladintyrion@gmail.com>

ENV VERSION 0.6.0-beta1
ENV SCOLLECTOR_HOME /scollector
ENV WORKPLACE /app
ENV TMPDIR /tmp
ENV URL https://github.com/bosun-monitor/bosun/releases/download
ENV PACKAGE scollector-linux-amd64

RUN set -x \
    && && mkdir -p ${WORKPLACE} \
    && apk update \
    && apk add --no-cache tzdata procps mlocate wget \
    && cd ${TMPDIR} \
    && wget --progress=bar:force -O "${URL}/${VERSION}/${PACKAGE}" \
    && mv ${PACKAGE} ${SCOLLECTOR_HOME}/scollector \
    && apk del wget \
    && ${SCOLLECTOR_HOME}/scollector -version \
    && set +x

WORKDIR /app

ENTRYPOINT ["/scollector/scollector"]
CMD ["--help"]
