Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
#
Write-Host "-------------"
Write-Host "Docker Status"
Write-Host "-------------"
docker ps -a
docker volume ls
docker network ls