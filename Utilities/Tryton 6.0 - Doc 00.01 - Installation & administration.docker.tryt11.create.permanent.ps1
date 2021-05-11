# Environment : Windows 10 - Powershell - Docker - Tryton 5.8
# tryt11
# 5443:5432
# 8011:8000
# tryton/tryton:latest
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
Set-PSDebug -Trace 1
Set-PSDebug -Off
#
docker pull tryton/tryton:latest
#
docker network create tryt11-network
$POSTGRES_PASSWORD ="Password"

# tryt11 database container
Write-Host "----------------------------"
Write-Host "1. tryt11 database container"
Write-Host "----------------------------"
$TRYTON_VOL_DB = (Get-Location).tostring().replace("\","/").replace("C:/","c//") + "/"+"tryt11-database"
# docker volume create tryt11-database - for future use
docker run --name tryt11-postgres --env PGDATA=/var/lib/postgresql/data/pgdata --env POSTGRES_DB=tryt11 --env POSTGRES_PASSWORD=${POSTGRES_PASSWORD} --volume ${TRYTON_VOL_DB}:/var/lib/postgresql/data --network tryt11-network -p 5443:5432 --detach postgres
Start-Sleep -Seconds 30 # Replace by detecting database is 'up'
docker exec -tiu postgres tryt11-postgres psql -c '\l+'

# tryt11 transient container to initialize the tryton database in its container
Write-Host "---------------------------------"
Write-Host "2. tryt11 database initialization"
Write-Host "---------------------------------"
docker run --env DB_HOSTNAME=tryt11-postgres --env DB_PASSWORD=${POSTGRES_PASSWORD} --network tryt11-network --interactive --tty --rm tryton/tryton:latest trytond-admin -d tryt11 --all # 'tryton/tryton:latest trytond-admin -d tryt11' : from 'tryton/tryton:latest' run 'trytond-admin' against the 'tryt11' database
docker exec -tiu postgres tryt11-postgres psql -c '\l+'

# tryt11 server containers : tryt11 & optionally tryt11-cron for scheduled actions
Write-Host "-------------------------------------------------------------"
Write-Host "3. tryt11 server containers : tryt11 & optionally tryt11-cron"
Write-Host "-------------------------------------------------------------"
$TRYTON_VOL_FI = (Get-Location).tostring().replace("\","/").replace("C:/","c//") + "/"+"tryt11-datafile"
# docker volume create tryt11-datafile - for future use
docker run --name tryt11 --env DB_HOSTNAME=tryt11-postgres --env DB_PASSWORD=${POSTGRES_PASSWORD} --volume ${TRYTON_VOL_FI}:/var/lib/trytond/db --network tryt11-network -p 8011:8000 --detach tryton/tryton:latest
docker run --name tryt11-cron --env DB_HOSTNAME=tryt11-postgres --env DB_PASSWORD=${POSTGRES_PASSWORD} --volume ${TRYTON_VOL_FI}:/var/lib/trytond/db --network tryt11-network --detach tryton/tryton:latest trytond-cron -d tryt11 # 'tryton/tryton:latest trytond-cron -d tryt11' : from 'tryton/tryton:latest' run 'trytond-cron' against the 'tryt11' database

# final status
Write-Host "----------------------"
Write-Host "4. tryt11 final status"
Write-Host "----------------------"
docker ps -a
# Obtain Gateway address for usage in pgadmin4 - creating server
docker inspect tryt11-postgres -f "{{json .NetworkSettings.Networks}}" # "Gateway":"172.18.0.1","IPAddress":"172.18.0.2"

#
Write-Host "-------"
Write-Host "5. Done"
Write-Host "-------"