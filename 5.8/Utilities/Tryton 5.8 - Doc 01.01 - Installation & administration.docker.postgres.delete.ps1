# Environment : Windows 10 - Powershell - Docker - Tryton 5.8
# d01-postgres
# d01-pgadmin

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
Set-PSDebug -Off
Write-Host "About to delete d01-postgres & d01-pgadmin & permanent data base"
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
Write-Host "--------------------"
Write-Host "2. Delete all tryt01"
Write-Host "--------------------"
docker stop d01-postgres d01-pgadmin
docker rm d01-postgres d01-pgadmin
Remove-Item -Recurse -Force ${HOME}/d01-postgres-data
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