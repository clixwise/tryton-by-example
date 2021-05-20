Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
#
Write-Host "------------------"
Write-Host "1. Stop containers"
Write-Host "------------------"
docker stop tryt11-postgres tryt11 tryt11-cron
docker ps -a
#
Write-Host "-------"
Write-Host "2. Done"
Write-Host "-------"
Pause