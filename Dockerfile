FROM bludoc/php5_apache_mysql5_enabled

LABEL maintainer="Bjoern Ludwig <bjoern.ludwig@ptb.de>"

Run apt-get update && apt-get install -y \
      git

# Clone the current version of TemaTres from github.com.
WORKDIR /var/www/html/

RUN git clone "https://github.com/tematres/TemaTres-Vocabulary-Server.git" .

COPY entrypoint.sh /entrypoint.sh

VOLUME /var/www/html/

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
