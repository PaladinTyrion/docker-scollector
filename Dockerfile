FROM alpine:3.7
MAINTAINER PaladinTyrion <paladintyrion@gmail.com>

ENV VERSION 0.6.0-beta1
ENV SCOLLECTOR_HOME /scollector
ENV WORKPLACE /app
ENV TMPDIR /tmp
ENV URL https://github.com/bosun-monitor/bosun/releases/download
ENV PACKAGE scollector-linux-amd64

RUN set -x \
    && mkdir -p ${WORKPLACE} ${SCOLLECTOR_HOME} \
    && apk update \
    && apk add --no-cache tzdata procps wget \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && wget --progress=bar:force -O ${PACKAGE} "${URL}/${VERSION}/${PACKAGE}" \
    && mv ${PACKAGE} ${SCOLLECTOR_HOME}/scollector \
    && chmod +x ${SCOLLECTOR_HOME}/scollector \
    && ${SCOLLECTOR_HOME}/scollector -version \
    && apk del wget \
    && set +x

WORKDIR /app

ENTRYPOINT ["/scollector/scollector"]
CMD ["--help"]
