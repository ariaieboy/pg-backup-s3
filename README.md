# pg-backup-s3
a docker image to back up Postgres into the S3-compatible storage

this repo is based on [schickling/dockerfiles](https://github.com/schickling/dockerfiles/tree/master/postgres-backup-s3).

the difference here is that we use Ubuntu as a base image and because of that we can add an official repository of Postgresql and get a more updated version of Postgresql.

this image currently uses `postgresql-client-17` that supports versions 12-17 of PostgreSQL.

if you need older Postgresql you need to manually change the docker file and build the image with the compatible client.

## Usage

Docker:
```sh
$ docker run -e S3_ACCESS_KEY_ID=key -e S3_SECRET_ACCESS_KEY=secret -e S3_BUCKET=my-bucket -e S3_PREFIX=backup -e POSTGRES_DATABASE=dbname -e POSTGRES_USER=user -e POSTGRES_PASSWORD=password -e POSTGRES_HOST=localhost ariaieboy/pg-backup-s3
```

Docker Compose:
```yaml
postgres:
  image: postgres
  environment:
    POSTGRES_USER: user
    POSTGRES_PASSWORD: password

pgbackups3:
  image: ariaieboy/pg-backup-s3
  depends_on:
    - postgres
  links:
    - postgres
  environment:
    REMOVE_BEFORE: 30 //optional
    SCHEDULE: '@daily'
    S3_REGION: region
    S3_ACCESS_KEY_ID: key
    S3_SECRET_ACCESS_KEY: secret
    S3_BUCKET: my-bucket
    S3_PREFIX: backup
    POSTGRES_BACKUP_ALL: "false"
    POSTGRES_HOST: host
    POSTGRES_DATABASE: dbname
    POSTGRES_USER: user
    POSTGRES_PASSWORD: password
    POSTGRES_EXTRA_OPTS: '--schema=public --blobs'
```

### Automatic Periodic Backups

You can additionally set the `SCHEDULE` environment variable like `-e SCHEDULE="@daily"` to run the backup automatically.

More information about the scheduling can be found [here](http://godoc.org/github.com/robfig/cron#hdr-Predefined_schedules).

### Backup All Databases

You can backup all available databases by setting `POSTGRES_BACKUP_ALL="true"`.

Single archive with the name `all_<timestamp>.sql.gz` will be uploaded to S3

### Endpoints for S3

An Endpoint is the URL of the entry point for an AWS web service or S3 Compitable Storage Provider.

You can specify an alternate endpoint by setting `S3_ENDPOINT` environment variable like `protocol://endpoint`

**Note:** S3 Compitable Storage Provider requires `S3_ENDPOINT` environment variable

## Automatic Cleanup

You can remove old backups by setting the `REMOVE_BEFORE` environment for example if you pass 30 it will remove files older than 30 days old.

### Encryption

You can additionally set the `ENCRYPTION_PASSWORD` environment variable like `-e ENCRYPTION_PASSWORD="superstrongpassword"` to encrypt the backup. It can be decrypted using `openssl aes-256-cbc -d -in backup.sql.gz.enc -out backup.sql.gz`.
