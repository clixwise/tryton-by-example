Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

# Step 1 : docker stop/start containers
Write-Host "-------------------------------"
Write-Host "1. Docker stop/start containers"
Write-Host "-------------------------------"
docker stop post01-postgres post01-pgadmin
docker start post01-postgres post01-pgadmin

# Step 2 : state
Write-Host "---------"
Write-Host "2. Status"
Write-Host "---------"
docker ps -a
Start-Sleep -Seconds 30 # Replace by detecting database is 'up'
docker exec -tiu postgres post01-postgres psql -c '\l+'

# Step 3 : drop and create post01-copy
Write-Host "------------------------------"
Write-Host "3. Drop and create post01-copy"
Write-Host "------------------------------"
docker exec post01-postgres dropdb -f -U postgres post01-copy
docker exec post01-postgres createdb -U postgres -T template0 post01-copy

# Step 4.1 : import inside container (optional ; function of step 1.2 above)
Write-Host "----------------------------"
Write-Host "4.1. Import inside container"
Write-Host "----------------------------"
docker cp post01-db-backup.tar post01-postgres:/post01-db-backup.tar

# Step 4.2 : restore post01-copy from post01
Write-Host "------------------------------------"
Write-Host "4.2. Restore post01-copy from post01"
Write-Host "------------------------------------"
docker exec -i post01-postgres pg_restore -Ft -U postgres -d post01-copy -v ./post01-db-backup.tar

# Step 5 : state
Write-Host "---------"
Write-Host "5. Status"
Write-Host "---------"
docker exec -tiu postgres post01-postgres psql -c '\l+'
#
Write-Host "-------"
Write-Host "6. Done"
Write-Host "-------"
Pause

