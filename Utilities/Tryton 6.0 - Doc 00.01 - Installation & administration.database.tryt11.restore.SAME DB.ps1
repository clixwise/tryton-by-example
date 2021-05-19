Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

# Step 1 : docker stop/start containers
Write-Host "-------------------------------"
Write-Host "1. Docker stop/start containers"
Write-Host "-------------------------------"
docker stop tryt11-postgres tryt11
docker start tryt11-postgres tryt11

# Step 2 : state
Write-Host "---------"
Write-Host "2. Status"
Write-Host "---------"
docker ps -a
Start-Sleep -Seconds 30 # Replace by detecting database is 'up'
docker exec -tiu postgres tryt11-postgres psql -c '\l+'

# Step 3 : drop and create tryt11
Write-Host "------------------------------"
Write-Host "3. Drop and create tryt11"
Write-Host "------------------------------"
docker exec tryt11-postgres dropdb -f -U postgres tryt11
docker exec tryt11-postgres createdb -U postgres -T template0 tryt11

# Step 4.1 : import inside container (optional ; function of step 1.2 above)
Write-Host "----------------------------"
Write-Host "4.1. Import inside container"
Write-Host "----------------------------"
docker cp tryt11-db-backup.tar tryt11-postgres:/tryt11-db-backup.tar

# Step 4.2 : restore tryt11 from tryt11
Write-Host "------------------------------------"
Write-Host "4.2. Restore tryt11 from tryt11"
Write-Host "------------------------------------"
docker exec -i tryt11-postgres pg_restore -Ft -U postgres -d tryt11 -v ./tryt11-db-backup.tar

# Step 5 : state
Write-Host "---------"
Write-Host "5. Status"
Write-Host "---------"
docker exec -tiu postgres tryt11-postgres psql -c '\l+'
#
Write-Host "-------"
Write-Host "6. Done"
Write-Host "-------"
Pause
