#!/bin/bash
set -e

# This entrypoint script is an adaption of the awesom script found here:
# https://github.com/BjoernLudwigPTB/dockerfiles/blob/master/etherpad-lite/entrypoint.sh
# to the application TemaTres.

# The following descriptions are a slightly enhanced version taken from
#   https://github.com/tematres/TemaTres-Vocabulary-Server/blob/master/vocab/db.tematres.php
#
# Select driver to use
# Default: MySQLi , can be mysqli,postgres, oci8, mssql, and more:
#   http://phplens.com/adodb/supported.databases.html
# To default value, leave empty eg: $DBCFG["DBdriver"] ="";
: ${DBDRIVER:=mysql}
# Dirección IP o nombre del servidor - IP Address of the database server
# Use the container_name in Docker context,
: ${SERVER:=tematres_mysql}
# Nombre de la base de datos Database name
: ${DBNAME:=tematres}
#  Nombre de usuario - login
# Use the MySQL username for the specified database
: ${DBLOGIN:=tematres}
# Prefijo para tablas # Prefix for tables
: ${DBPREFIX:=vocab_}

# Adapt the installation to local needs by inserting the passed build args. This
# enables the connection to the mysql database.
sed -i \
    -e 's/$DBCFG\["DBdriver"\] ="";/$DBCFG["DBdriver"] ="'$DBDRIVER'";/g' \
    -e 's/$DBCFG\["Server"\]      = "localhost";/$DBCFG["Server"]      = "'$SERVER'";/g' \
    -e 's/$DBCFG\["DBName"\]     = "tematres";/$DBCFG["DBName"]     = "'$DBNAME'";/g' \
    -e 's/$DBCFG\["DBLogin"\]    = "root";/$DBCFG["DBLogin"]    = "'$DBLOGIN'";/g' \
    -e 's/$DBCFG\["DBPass"\] = "pass";/$DBCFG["DBPass"] = "'$DBPASS'";/g' \
    -e 's/$DBCFG\["DBprefix"\] = "glosaknoc__";/$DBCFG["DBprefix"] = "'$DBPREFIX'";/g' \
    -e 's#Etc/UTC#Europe/Berlin#g' \
    vocab/db.tematres.php && \
    # Remove the if condition around the desired timezone to avoid the
    # warning that `date_default_timezone_get()` should not be used.
    sed -i '/if(date_default_timezone_get()!=.*/d' vocab/db.tematres.php && \
    sed -i '/}/d' vocab/db.tematres.php

# Avoid a later error due to limited rights in the filesystem.
chmod -R 777 \
  common/include/htmlpurifier/HTMLPurifier/DefinitionCache/Serializer

docker-php-entrypoint apache2-foreground
