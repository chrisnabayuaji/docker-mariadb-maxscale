#!/bin/bash
echo
echo Starting deploying...
echo

export DB_NAME_1=${MYSQL_DB_NAME_1:-'db-1'}
export DB_NAME_2=${MYSQL_DB_NAME_2:-'db-2'}
export DB_NAME_3=${MYSQL_DB_NAME_3:-'db-3'}

export MAXSCALE_USER=${MYSQL_REPL_USER_1:-'maxuser'}
export MAXSCALE_PASS=${MYSQL_REPL_PASS_1:-'maxpwd'}

export ROOT_PASS_1=${MYSQL_ROOT_PASS_1:-'root'}
export ROOT_PASS_2=${MYSQL_ROOT_PASS_2:-'root'}
export ROOT_PASS_3=${MYSQL_ROOT_PASS_2:-'root'}

export HOST_1=${MYSQL_HOST_1:-'db-1'}
export HOST_2=${MYSQL_HOST_2:-'db-2'}
export HOST_3=${MYSQL_HOST_3:-'db-3'}

docker-compose -f docker-compose.yml up -d

echo
echo Waiting 60s for containers to be up and running...
sleep 60
echo

echo Create maxscale user on db-1 database...
docker exec $HOST_1 \
  mysql -u root --password=$ROOT_PASS_1 \
  --execute="CREATE USER '$MAXSCALE_USER'@'%' IDENTIFIED BY '$MAXSCALE_PASS';\
  GRANT ALL PRIVILEGES ON *.* TO '$MAXSCALE_USER'@'%';\
  FLUSH PRIVILEGES;"

echo Create maxscale user on db-2 database...
docker exec $HOST_2 \
  mysql -u root --password=$ROOT_PASS_2 \
  --execute="CREATE USER '$MAXSCALE_USER'@'%' IDENTIFIED BY '$MAXSCALE_PASS';\
  GRANT ALL PRIVILEGES ON *.* TO '$MAXSCALE_USER'@'%';\
  FLUSH PRIVILEGES;"

echo Create maxscale user on db-3 database...
docker exec $HOST_3 \
  mysql -u root --password=$ROOT_PASS_3 \
  --execute="CREATE USER '$MAXSCALE_USER'@'%' IDENTIFIED BY '$MAXSCALE_PASS';\
  GRANT ALL PRIVILEGES ON *.* TO '$MAXSCALE_USER'@'%';\
  FLUSH PRIVILEGES;"