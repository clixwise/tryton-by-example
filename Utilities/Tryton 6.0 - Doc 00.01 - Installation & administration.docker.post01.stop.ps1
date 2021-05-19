Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
#
Write-Host "------------------"
Write-Host "1. Stop containers"
Write-Host "------------------"
docker stop post01-postgres post01-pgadmin
docker ps -a
#
Write-Host "-------"
Write-Host "2. Done"
Write-Host "-------"
Pause