# tryt11
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
#
Write-Host "------------------"
Write-Host "1. Stop containers"
Write-Host "------------------"
docker stop post01-postgres post01-pgadmin
#
Write-Host "-------------------"
Write-Host "2. Start containers"
Write-Host "-------------------"
docker start post01-postgres post01-pgadmin
#
Write-Host "----------------"
Write-Host "3. Docker Status"
Write-Host "----------------"
docker ps -a
Start-Sleep -Seconds 20 # Replace by detecting database is 'up'
docker exec -tiu postgres post01-postgres psql -c '\l+'
#
Write-Host "-------"
Write-Host "4. Done"
Write-Host "-------"
Pause