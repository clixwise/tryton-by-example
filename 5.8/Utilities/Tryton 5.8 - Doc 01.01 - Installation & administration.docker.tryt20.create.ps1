# Environment : Windows 10 - Powershell - Docker - Tryton 5.8
# https://stackoverflow.com/questions/35069027/docker-wait-for-postgresql-to-be-running
# https://docs.docker.com/compose/startup-order/
# https://stackoverflow.com/questions/26911508/postgres-testing-database-connection-in-bash
# tryt20
# 5452:5432
# 8020:8000
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
Set-PSDebug -Trace 1
Set-PSDebug -Off
Remove-Item -Recurse -Force tryt20-database
Remove-Item -Recurse -Force tryt20-datafile
#
docker network create tryt20-network
$POSTGRES_PASSWORD ="Password"
# Tryton database container – Create
$TRYTON_VOL_DB = (Get-Location).tostring().replace("\","/").replace("C:/","c//") + "/"+"tryt20-database"
docker volume create tryt20-database
docker run --name tryt20-postgres --env PGDATA=/var/lib/postgresql/data/pgdata --env POSTGRES_DB=tryt20 --env POSTGRES_PASSWORD=${env:POSTGRES_PASSWORD} --volume ${TRYTON_VOL_DB}:/var/lib/postgresql/data --network tryt20-network -p 5452:5432 --detach postgres
# docker exec tryt20-postgres pg_isready --dbname=tryt20
# /var/run/postgresql:5432 - accepting connections
# VAR=$(pg_isready --dbname=tryt20)
# echo $VAR
Start-Sleep -Seconds 10
# docker exec tryt20-postgres pg_isready --dbname=tryt20
# /var/run/postgresql:5432 - accepting connections
# DO {Start-Sleep -Seconds 1;} UNTIL (docker run --rm --link tryt20-postgres:pg --net tryt20-network postgres pg_isready -U postgres -h pg)
docker exec -tiu postgres tryt20-postgres psql -c '\l+'
dir
# Tryton transient container to initialize the tryton database in its container
docker run --env DB_HOSTNAME=tryt20-postgres --env DB_PASSWORD=${POSTGRES_PASSWORD} --network tryt20-network --interactive --tty --rm tryton/tryton trytond-admin -d tryt20 --all
docker exec -tiu postgres tryt20-postgres psql -c '\l+'
# Tryton server container
$TRYTON_VOL_FI = (Get-Location).tostring().replace("\","/").replace("C:/","c//") + "/"+"tryt20-datafile"
docker volume create tryt20-datafile
docker run --name tryt20 --env DB_HOSTNAME=tryt20-postgres --env DB_PASSWORD=${POSTGRES_PASSWORD} --volume ${TRYTON_VOL_FI}:/var/lib/trytond/db --network tryt20-network --publish 127.0.0.1:8020:8000 --detach tryton/tryton
dir
# Obtain Gateway address for usage in pgadmin4 - creating server
docker inspect tryt20-postgres -f "{{json .NetworkSettings.Networks }}" # "Gateway":"172.18.0.1","IPAddress":"172.18.0.2"
Pause