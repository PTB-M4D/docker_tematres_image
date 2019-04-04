# TemaTres Docker image

This repository holds the configuration for a Docker image based on
*bludoc/php5_apache_mysql5_enabled*, which serves
***TemaTres Vocabulary Server*** in PHP 5.6 over an Apache webserver and the
enabled MySQL extension.

# Build process
The build process is comprised of few steps.

## Install Git
First update the package sources and install Git (lines 5-7).

## Clone the code
Pull the current version of the application from
[GitHub.com](https://github.com/tematres/TemaTres-Vocabulary-Server) using `git
clone` (lines 8-12).

## Copy script to enable application set up
Copy [entrypoint.sh](./entrypoint.sh) to the root directory of the image to
enable the setup process of the databse connection on container startup.

## Expose port 80
Expose container port 80 to the host for viewing the application in a browser.

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
-   `DBDRIVER = mysql`: Select driver to use
  can be mysqli,postgres, oci8, mssql, and [more
  ](http://phplens.com/adodb/supported.databases.html).
-   `SERVER = tematres_mysql`: Dirección IP o nombre del servidor - IP Address
    or qualified name of the database server. Use the container_name in Docker context.
-   `DBNAME = tematres`: Nombre de la base de datos Database name.
-   `DBLOGIN = tematres`: Nombre de usuario - login. Use the MySQL username for
    the specified database.
-   `DBPREFIX = vocab_`: Prefijo para tablas. Prefix for tables.
