FROM alpine:3.7
MAINTAINER PaladinTyrion <paladintyrion@gmail.com>

ENV GOPATH /gobuild
WORKDIR /gobuild

RUN set -x \
    && mkdir -p ${GOPATH} \
    && buildDeps='go git' \
    && apk add --update $buildDeps \
    && go get bosun.org/cmd/scollector \
    && mv ${GOPATH}/bin/scollector /usr/local/bin/scollector \
    && apk del $buildDeps \
    && /usr/local/bin/scollector -version \
    && set +x

ENTRYPOINT ["/usr/local/bin/scollector"]
CMD ["--help"]
