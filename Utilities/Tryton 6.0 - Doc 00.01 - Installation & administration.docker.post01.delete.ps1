# Environment : Windows 10 - Powershell - Docker - Tryton 5.8
# post01-postgres
# post01-pgadmin

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
Set-PSDebug -Off
Write-Host "About to delete post01-postgres & post01-pgadmin & permanent data base"
Pause
Pause
#
Write-Host "---------"
Write-Host "1. Status"
Write-Host "---------"
docker ps -a
docker network ls
docker volume ls
dir
#
Write-Host "----------------------------------------------"
Write-Host "2. Delete all post01-postgres & post01-pgadmin"
Write-Host "----------------------------------------------"
docker stop post01-postgres post01-pgadmin
docker rm post01-postgres post01-pgadmin
Remove-Item -Recurse -Force ${HOME}/post01-postgres # HOME == USER
#
Write-Host "---------"
Write-Host "3. Status"
Write-Host "---------"
docker ps -a
docker network ls
docker volume ls
dir
#
Write-Host "-------"
Write-Host "4. Done"
Write-Host "-------"
Pause