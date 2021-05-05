# tryt01
# 8001
# 5433:5432
# Obtain latest version of tryt01
# docker pull tryton/tryton

# tryt01 database container
Write-Host "----------------------------"
Write-Host "1. tryt01 database container"
Write-Host "----------------------------"
docker run --name tryt01-postgres -e POSTGRES_PASSWORD=Password -e POSTGRES_DB=tryt01 -p 5433:5432 -d postgres # Start a PostgreSQL instance
Start-Sleep -Seconds 20 # Replace by detecting database is 'up'
docker exec -tiu postgres tryt01-postgres psql -c '\l+'

# tryt01 database initialization
Write-Host "---------------------------------"
Write-Host "2. tryt01 database initialization"
Write-Host "---------------------------------"
docker run --link tryt01-postgres:postgres -e DB_PASSWORD=Password --rm -it tryton/tryton trytond-admin -d tryt01 --all # Define database tables
# "admin" email for "tryt01": x@gmail.com
# "admin" password for "tryt01":
# "admin" password confirmation:
Start-Sleep -Seconds 20 # Replace by detecting database is 'up'
docker exec -tiu postgres tryt01-postgres psql -c '\l+'

# tryt01 server containers : tryt01 & optionally tryt01-cron for scheduled actions
Write-Host "-------------------------------------------------------------"
Write-Host "3. tryt01 server containers : tryt01 & optionally tryt01-cron"
Write-Host "-------------------------------------------------------------"
docker run --name tryt01 -p 8001:8000 --link tryt01-postgres:postgres -e DB_PASSWORD=Password -d tryton/tryton # Start a tryt01 instance
docker run --name tryt01-cron --link tryt01-postgres:postgres -e DB_PASSWORD=Password -d tryton/tryton trytond-cron -d tryt01 # Start a cron instance

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