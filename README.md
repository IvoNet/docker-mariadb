# ivonet/mariadb Docker image

A specific image for MariaDB based on the standard MariaDB image.

This image has to be build on your local machine to make the 
development environment work.

This image is tuned to monitor a TEST_DIR folder file up and running.
if you put sql files into this folder they will be executed on the database
and when done removed.

This image is strongly based on the ivonet/mysql image with the same intentions
The reason this image was created is that mysql does not have arm64 platform images
and mariadb has.

## How to build

```shell
docker build -t ivonet/mariadb .
```

## What it does

* Create a mysql image
* Add a custom entrypoint
* Configures mysql to monitor for testdata
* Create an image tagged as `ivonet/mariadb`
* Push the image to docker hub


## Why

My version of the MySql image exposes a `/testdata` folder and that folder is monitored for changes.
When changes detected, it will execute it on the running database.
You can put testdata `*.sql` files there. Note that the files will also be removed from that folder after it has been consumed against the db. Only `*.sql` files will be consumed. all other files will be ignored. A log file in that folder will give feedback on what happened.

## A docker compose example

The `docker-compose.yml` file below exposes two native volumes:

./volumes/setup: Put your setup *.sql files here. e.g. CREATE statements 
./volumes/testdata: copy your testdata *.sql files here. These files will be 'consumed' into the database. 

It will also enable a phpmyadmin for further db control...

