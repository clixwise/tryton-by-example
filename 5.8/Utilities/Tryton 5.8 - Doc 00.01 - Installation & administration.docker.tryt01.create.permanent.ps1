# Environment : Windows 10 - Powershell - Docker - Tryton 5.8
# tryt01
# 5433:5432
# 8001:8000
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
Set-PSDebug -Trace 1
Set-PSDebug -Off
#
docker network create tryt01-network
$POSTGRES_PASSWORD ="Password"

# tryt01 database container
Write-Host "----------------------------"
Write-Host "1. tryt01 database container"
Write-Host "----------------------------"
$TRYTON_VOL_DB = (Get-Location).tostring().replace("\","/").replace("C:/","c//") + "/"+"tryt01-database"
# docker volume create tryt01-database
docker run --name tryt01-postgres --env PGDATA=/var/lib/postgresql/data/pgdata --env POSTGRES_DB=tryt01 --env POSTGRES_PASSWORD=${POSTGRES_PASSWORD} --volume ${TRYTON_VOL_DB}:/var/lib/postgresql/data --network tryt01-network -p 5433:5432 --detach postgres
Start-Sleep -Seconds 20 # Replace by detecting database is 'up'
docker exec -tiu postgres tryt01-postgres psql -c '\l+'

# tryt01 transient container to initialize the tryton database in its container
Write-Host "---------------------------------"
Write-Host "2. tryt01 database initialization"
Write-Host "---------------------------------"
docker run --env DB_HOSTNAME=tryt01-postgres --env DB_PASSWORD=${POSTGRES_PASSWORD} --network tryt01-network --interactive --tty --rm tryton/tryton trytond-admin -d tryt01 --all # 'tryton/tryton trytond-admin -d tryt01' : from 'tryton/tryton' run 'trytond-admin' against the 'tryt01' database
docker exec -tiu postgres tryt01-postgres psql -c '\l+'

# tryt01 server containers : tryt01 & optionally tryt01-cron for scheduled actions
Write-Host "-------------------------------------------------------------"
Write-Host "3. tryt01 server containers : tryt01 & optionally tryt01-cron"
Write-Host "-------------------------------------------------------------"
$TRYTON_VOL_FI = (Get-Location).tostring().replace("\","/").replace("C:/","c//") + "/"+"tryt01-datafile"
# docker volume create tryt01-datafile
docker run --name tryt01 --env DB_HOSTNAME=tryt01-postgres --env DB_PASSWORD=${POSTGRES_PASSWORD} --volume ${TRYTON_VOL_FI}:/var/lib/trytond/db --network tryt01-network -p 8001:8000 --detach tryton/tryton
docker run --name tryt01-cron --env DB_HOSTNAME=tryt01-postgres --env DB_PASSWORD=${POSTGRES_PASSWORD} --volume ${TRYTON_VOL_FI}:/var/lib/trytond/db --network tryt01-network --detach tryton/tryton trytond-cron -d tryt01 # 'tryton/tryton trytond-cron -d tryt01' : from 'tryton/tryton' run 'trytond-cron' against the 'tryt01' database

# final status
Write-Host "----------------------"
Write-Host "4. tryt01 final status"
Write-Host "----------------------"
docker ps -a
# Obtain Gateway address for usage in pgadmin4 - creating server
docker inspect tryt01-postgres -f "{{json .NetworkSettings.Networks }}" # "Gateway":"172.18.0.1","IPAddress":"172.18.0.2"

#
Write-Host "-------"
Write-Host "5. Done"
Write-Host "-------"