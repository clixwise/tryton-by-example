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

# Step 4.1 : import inside container (optional ; function of step 1.2 above)
Write-Host "----------------------------"
Write-Host "4.1. Import inside container"
Write-Host "----------------------------"
docker cp post01-db-backup.createYes.sql post01-postgres:/post01-db-backup.createYes.sql

# Step 4.2 : restore post01-copy from post01
Write-Host "------------------------------------------------------------------------------------------------"
Write-Host "4.2. Restore post01-copy from post01 [!!! DROP & CREATE inside 'post01-db-backup.createYes.sql']"
Write-Host "------------------------------------------------------------------------------------------------"
docker exec -i post01-postgres psql -U postgres -f post01-db-backup.createYes.sql

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

