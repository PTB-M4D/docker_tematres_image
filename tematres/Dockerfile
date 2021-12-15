FROM alpine:3.12

LABEL maintainer="Bjoern Ludwig <bjoern.ludwig@ptb.de>"

RUN apk update && apk add curl wget unzip

# Clone the current version of TemaTres from sourceforge.net.
WORKDIR /opt/tematres/

RUN TAG_NAME=$(curl -s \
    https://api.github.com/repos/tematres/TemaTres-Vocabulary-Server/releases/latest | \
    grep 'tag_name' | cut -d '"' -f 4) && \
    echo "https://codeload.github.com/tematres/TemaTres-Vocabulary-Server/\
zip/refs/tags/$TAG_NAME" | \
    wget -i - && unzip $TAG_NAME && rm $TAG_NAME

RUN mv TemaTres*/* . && \
      rm -rf TemaTres*

COPY docker-entrypoint.sh /docker-entrypoint.sh

VOLUME /opt/tematres/

ENTRYPOINT ["sh", "/docker-entrypoint.sh"]
