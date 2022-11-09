# pg-backup-s3
a docker image to back up postgres into the S3 compatible storage

this repo is based on [schickling/dockerfiles](https://github.com/schickling/dockerfiles/tree/master/postgres-backup-s3).

the difference here is that we use ubuntu as base image and because of that we can add official repository of postgresql and get more updatged version of postgresql.

right now this image uses `postgresql-client-15` that supports version 10-15 of postgresql.

if you need older postgresql you need to manually change the docker file and build the image with compatible client.