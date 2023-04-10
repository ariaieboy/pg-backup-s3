FROM webdevops/go-crond:master-ubuntu
LABEL maintainer="AriaieBOY <smr.seddighy@gmail.com>"
ENV DEBIAN_FRONTEND noninteractive
ENV TZ=UTC

RUN apt-get update
RUN apt-get -y install wget gnupg
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt jammy-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt-get update
RUN apt-get -yq install postgresql-client-15 openssl awscli

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV POSTGRES_DATABASE **None**
ENV POSTGRES_BACKUP_ALL **None**
ENV POSTGRES_HOST **None**
ENV POSTGRES_PORT 5432
ENV POSTGRES_USER **None**
ENV POSTGRES_PASSWORD **None**
ENV POSTGRES_EXTRA_OPTS ''
ENV S3_ACCESS_KEY_ID **None**
ENV S3_SECRET_ACCESS_KEY **None**
ENV S3_BUCKET **None**
ENV S3_REGION us-west-1
ENV S3_PATH 'backup'
ENV S3_ENDPOINT **None**
ENV S3_S3V4 no
ENV SCHEDULE **None**
ENV ENCRYPTION_PASSWORD **None**
ENV REMOVE_BEFORE ''

ADD run.sh /scripts/run.sh
ADD backup.sh /scripts/backup.sh


ENTRYPOINT []
CMD ["sh", "/scripts/run.sh"]