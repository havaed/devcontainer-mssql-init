#!/usr/bin/env bash

if ! [ -f /var/opt/mssql/.initialized ]; then
  while ! 2> /dev/null > /dev/tcp/localhost/1433; do
    sleep 2
  done
  echo "Running set up script"
  /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master -i db-init.sql
  touch /var/opt/mssql/.initialized
fi &
/opt/mssql/bin/sqlservr