# TemaTres *docker-compose* set up

This repository holds the configuration of the set up process for a fully
working TemaTres instance using _docker-compose_.

After cloning the repository the file `.env` has to be modified to hold the
supposed database configuration. The file should be pretty self explanatory. To
start the application just issue the command

```shell
$ docker-compose up --detach
[...]
```

## Configuration

The application will be served on <http://localhost:9000> and store its data
persistently in two docker volumes, one holding the database and one holding the
application files and configuration.

### Change volume type

To change the named volume to a bind volume sharing the files to the host file
system change the following setting in the `docker-compose.yml`

```yml
# Start the php container with MySql extension installed.
app:
  ...
  volumes:
    - tematres:/var/www/html
  ...
```

to something like

```yml
# Start the php container with MySql extension installed.
app:
  ...
  volumes:
    - /path/to/your/host/folder:/var/www/html/
  ...
```
