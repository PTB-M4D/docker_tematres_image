FROM alpine

LABEL maintainer="Bjoern Ludwig <bjoern.ludwig@ptb.de>"

RUN apk update && apk add \
      curl \
      unzip

# Clone the current version of TemaTres from sourceforge.net.
WORKDIR /opt/tematres/

RUN curl -L https://sourceforge.net/projects/tematres/files/latest/download \
      --output tematres.zip && \
      unzip tematres.zip && \
      rm tematres.zip

RUN mv tematres*/* . && \
      rm -rf tematres*

COPY docker-entrypoint.sh /docker-entrypoint.sh

VOLUME /opt/tematres/

ENTRYPOINT ["sh", "/docker-entrypoint.sh"]
