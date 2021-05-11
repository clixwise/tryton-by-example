# tryt11
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
#
Write-Host "------------------"
Write-Host "1. Stop containers"
Write-Host "------------------"
docker stop tryt11-postgres tryt11 tryt11-cron
#
Write-Host "-------------------"
Write-Host "2. Start containers"
Write-Host "-------------------"
docker start tryt11-postgres tryt11 tryt11-cron
#
Write-Host "----------------"
Write-Host "3. Docker Status"
Write-Host "----------------"
docker ps -a
Start-Sleep -Seconds 30 # Replace by detecting database is 'up'
docker exec -tiu postgres tryt11-postgres psql -c '\l+'
#
Write-Host "-------"
Write-Host "4. Done"
Write-Host "-------"
Pause