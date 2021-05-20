# tryt11
# 8011
# 5443:5432
# docker pull tryton/tryton:latest
#
docker pull tryton/tryton:latest

# tryt11 database container
Write-Host "----------------------------"
Write-Host "1. tryt11 database container"
Write-Host "----------------------------"
docker run --name tryt11-postgres -e POSTGRES_PASSWORD=Password -e POSTGRES_DB=tryt11 -p 5443:5432 -d postgres # Start a PostgreSQL instance
Start-Sleep -Seconds 30 # Replace by detecting database is 'up'
docker exec -tiu postgres tryt11-postgres psql -c '\l+'

# tryt11 database initialization
Write-Host "---------------------------------"
Write-Host "2. tryt11 database initialization"
Write-Host "---------------------------------"
docker run --link tryt11-postgres:postgres -e DB_PASSWORD=Password --rm -it tryton/tryton:latest trytond-admin -d tryt11 --all # Define database tables
# "admin" email for "tryt11": x@gmail.com
# "admin" password for "tryt11":
# "admin" password confirmation:
Start-Sleep -Seconds 30 # Replace by detecting database is 'up'
docker exec -tiu postgres tryt11-postgres psql -c '\l+'

# tryt11 server containers : tryt11 & optionally tryt11-cron for scheduled actions
Write-Host "-------------------------------------------------------------"
Write-Host "3. tryt11 server containers : tryt11 & optionally tryt11-cron"
Write-Host "-------------------------------------------------------------"
docker run --name tryt11 -p 8011:8000 --link tryt11-postgres:postgres -e DB_PASSWORD=Password -d tryton/tryton:latest # Start a tryt11 instance
docker run --name tryt11-cron --link tryt11-postgres:postgres -e DB_PASSWORD=Password -d tryton/tryton:latest trytond-cron -d tryt11 # Start a cron instance

# final status
Write-Host "----------------------"
Write-Host "4. tryt11 final status"
Write-Host "----------------------"
docker ps -a
# Obtain Gateway address for usage in pgadmin4 - creating server
docker inspect tryt11-postgres -f "{{json .NetworkSettings.Networks }}" # "Gateway":"172.18.0.1","IPAddress":"172.18.0.2"

#
Write-Host "-------"
Write-Host "5. Done"
Write-Host "-------"