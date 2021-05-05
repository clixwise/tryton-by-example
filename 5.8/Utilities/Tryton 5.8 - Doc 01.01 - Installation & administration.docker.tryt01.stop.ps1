Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
#
Write-Host "------------------"
Write-Host "1. Stop containers"
Write-Host "------------------"
docker stop dev-postgres dev-pgadmin
docker stop tryt01-postgres tryt01 tryt01-cron
docker ps -a
#
Write-Host "-------"
Write-Host "2. Done"
Write-Host "-------"
Pause