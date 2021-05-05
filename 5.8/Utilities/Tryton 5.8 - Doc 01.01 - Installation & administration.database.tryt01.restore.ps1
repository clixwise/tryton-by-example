Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

# Step 1 : docker stop/start containers
Write-Host "-------------------------------"
Write-Host "1. Docker stop/start containers"
Write-Host "-------------------------------"
docker stop tryt01-postgres tryt01
docker start tryt01-postgres tryt01

# Step 2 : state
Write-Host "---------"
Write-Host "2. Status"
Write-Host "---------"
docker ps -a
Start-Sleep -Seconds 20 # Replace by detecting database is 'up'
docker exec -tiu postgres tryt01-postgres psql -c '\l+'

# Step 3 : drop and create tryt01-copy
Write-Host "------------------------------"
Write-Host "3. Drop and create tryt01-copy"
Write-Host "------------------------------"
docker exec tryt01-postgres dropdb -f -U postgres tryt01-copy
docker exec tryt01-postgres createdb -U postgres -T template0 tryt01-copy

# Step 4.1 : import inside container (optional ; function of step 1.2 above)
Write-Host "----------------------------"
Write-Host "4.1. Import inside container"
Write-Host "----------------------------"
docker cp tryt01-db-backup.tar tryt01-postgres:/tryt01-db-backup.tar

# Step 4.2 : restore tryt01-copy from tryt01
Write-Host "------------------------------------"
Write-Host "4.2. Restore tryt01-copy from tryt01"
Write-Host "------------------------------------"
docker exec -i tryt01-postgres pg_restore -Ft -U postgres -d tryt01-copy -v ./tryt01-db-backup.tar

# Step 5 : state
Write-Host "---------"
Write-Host "5. Status"
Write-Host "---------"
docker exec -tiu postgres tryt01-postgres psql -c '\l+'
#
Write-Host "-------"
Write-Host "6. Done"
Write-Host "-------"
Pause
