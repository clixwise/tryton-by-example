# Environment : Windows 10 - Powershell - Docker - Tryton 5.8
# tryt11
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
Set-PSDebug -Off
Write-Host "About to delete tryt11 & permanent data base"
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
Write-Host "2. Delete all tryt11"
Write-Host "--------------------"
docker stop tryt11-postgres tryt11 tryt11-cron
docker rm tryt11-postgres tryt11 tryt11-cron
docker network rm tryt11-network
docker volume rm tryt11-database tryt11-datafile
Remove-Item -Recurse -Force tryt11-database
Remove-Item -Recurse -Force tryt11-datafile
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