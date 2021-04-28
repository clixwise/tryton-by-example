# Environment : Windows 10 - Powershell - Docker - Tryton 5.8
# tryt20
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
Set-PSDebug -Off
Write-Host "About to delete tryt20"
Pause
dir
Remove-Item -Recurse -Force tryt20-database
Remove-Item -Recurse -Force tryt20-datafile
docker ps -a
docker network ls
docker volume ls
docker stop tryt20-postgres tryt20
docker rm tryt20-postgres tryt20
docker network rm tryt20-network
docker volume rm t20-database tryt20-datafile
docker ps -a
docker network ls
docker volume ls
dir
Pause