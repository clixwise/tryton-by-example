Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

# Step 1 : state
Write-Host "---------"
Write-Host "1. Status"
Write-Host "---------"
docker ps -a
docker volume ls
docker network ls
docker inspect tryt11-postgres -f "{{.Name}} - {{json .NetworkSettings.Networks}}"
Start-Sleep -Seconds 30 # Replace by detecting database is 'up'
docker exec -tiu postgres tryt11-postgres psql -c '\l+'

# Step 2 : done
Write-Host "-------"
Write-Host "2. Done"
Write-Host "-------"

Pause
