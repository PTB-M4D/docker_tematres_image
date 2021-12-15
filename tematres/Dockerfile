FROM alpine

LABEL maintainer="Bjoern Ludwig <bjoern.ludwig@ptb.de>"

RUN apk update && apk add curl wget unzip

# Clone the current version of TemaTres from sourceforge.net.
WORKDIR /opt/tematres/

RUN TAG_NAME=$(curl -s \
    https://api.github.com/repos/tematres/TemaTres-Vocabulary-Server/releases/latest | \
    grep 'tag_name' | cut -d '"' -f 4)
RUN echo "https://codeload.github.com/tematres/TemaTres-Vocabulary-Server/zip/refs/tags/$TAG_NAME" | wget -i -
RUN unzip $TAG_NAME.zip && \
      rm $TAG_NAME.zip

RUN mv tematres*/* . && \
      rm -rf tematres*

COPY docker-entrypoint.sh /docker-entrypoint.sh

VOLUME /opt/tematres/

ENTRYPOINT ["sh", "/docker-entrypoint.sh"]
