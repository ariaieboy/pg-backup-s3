#! /bin/sh

apt-get update
apt-get -y install wget gnupg
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt jammy-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

apt-get update
apt-get -y install postgresql-client-15 openssl awscli

rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*