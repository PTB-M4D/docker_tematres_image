# TemaTres Docker image

[![Get your own version badge on microbadger.com](https://images.microbadger.com/badges/version/bludoc/tematres.svg)](https://microbadger.com/images/bludoc/tematres)
[![Get your own image badge on microbadger.com](https://images.microbadger.com/badges/image/bludoc/tematres.svg)](https://microbadger.com/images/bludoc/tematres)

This repository holds the configuration for a Docker image based on
*alpine*, which populates a docker volume with the application
***TemaTres Vocabulary Server***.

# Build process
The build process comprises few steps.

## Install *curl*, *wget* and *unzip*
First update the package sources and install *curl*, *wget* and *unzip* (line 5).

## Download the application
Pull the current stable version of the application from the latest
[GitHub.com release](https://github.com/tematres/TemaTres-Vocabulary-Server/releases/latest)
using `curl` (lines 10-13), unzip and delete the downloaded file. Afterwards
rearrange the folder structure.

## Copy script to enable application set up
Copy [docker-entrypoint.sh](./docker-entrypoint.sh) to the root directory of
the image to enable the setup process of the database connection on container
startup.

## Make sure the data is persistent

To make sure, that the TemaTres files are not overridden by a volume but
populate a volume as expected, we make `/opt/tematres`' content available to the
outside world.

# Environment variables
During container start there are several mandatory and optional environment
variables available to connect to an existing database. The following
descriptions are a slightly enhanced versions of the documentation taken from
[TemaTres GitHub-Repo](https://github.com/tematres/TemaTres-Vocabulary-Server/blob/master/vocab/db.tematres.php).

## Available environment variables
`DBPASS`: The only mandatory environment variable to set is the password for
the MySQL user to write to the specified database table.

### Optional variables
This list mentions the default value if not explicitly specified differently.
-   `DBDRIVER = `: Select driver to use
  can be mysqli, postgres, oci8, mssql, and
  [more](http://phplens.com/adodb/supported.databases.html).
-   `SERVER = tematres_mysql`: Dirección IP o nombre del servidor - IP Address
    or qualified name of the database server. Use the container name in Docker
    context.
-   `DBNAME = tematres`: Nombre de la base de datos Database name.
-   `DBLOGIN = tematres`: Nombre de usuario - login. Use the MySQL username for
    the specified database.
-   `DBPREFIX = vocab_`: Prefijo para tablas. Prefix for tables.
