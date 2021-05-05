# Environment : Windows 10 - Powershell - Docker - Tryton 5.8
# tryt01
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
Set-PSDebug -Off
Write-Host "About to delete tryt01"
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
docker stop tryt01-postgres tryt01 tryt01-cron
docker rm tryt01-postgres tryt01 tryt01-cron
docker network rm tryt01-network
docker volume rm tryt01-database tryt01-datafile
Remove-Item -Recurse -Force tryt01-database
Remove-Item -Recurse -Force tryt01-datafile
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