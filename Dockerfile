FROM frolvlad/alpine-glibc
MAINTAINER PaladinTyrion <paladintyrion@gmail.com>

ENV VERSION 0.7.0
ENV SCOLLECTOR_HOME /scollector
ENV GOPATH /gobuild
ENV GOROOT /usr/local/go
ENV PATH $PATH:/usr/local/go/bin:/usr/local/bin
ENV GO_PACKAGE go1.9.4.linux-amd64.tar.gz
ENV WORKPLACE /app

WORKDIR /tmp

RUN set -x \
    && mkdir -p ${WORKPLACE} ${SCOLLECTOR_HOME} ${GOPATH} \
    && apk update \
    && apk add --no-cache tzdata procps wget git \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && wget --progress=bar:force -O ${GO_PACKAGE} "https://dl.google.com/go/${GO_PACKAGE}" \
    && tar -C /usr/local -xzf ${GO_PACKAGE} \
    && rm -fr ${GO_PACKAGE} \
    && go version \
    && set +x

# install the latest scollector
RUN set -x \
    && go get -u bosun.org/cmd/bosun \
    && cd $GOPATH/src/bosun.org/build \
    && go build -tags="esv5" \
    && ./build \
    && mv $GOPATH/bin/scollector $SCOLLECTOR_HOME/scollector \
    && chmod +x $SCOLLECTOR_HOME/scollector \
    && $SCOLLECTOR_HOME/scollector -version \
    && apk del wget git \
    && set +x

WORKDIR /app

ENTRYPOINT ["/scollector/scollector"]
CMD ["--help"]
