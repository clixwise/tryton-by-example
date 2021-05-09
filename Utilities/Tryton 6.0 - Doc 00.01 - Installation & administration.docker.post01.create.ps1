Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

# post01-postgres
# post01-pgadmin
# 81:80
# 5433:5432

# postgres
Write-Host "-------------------------------------------"
Write-Host "1. Create Postgres Container 'post01-postgres'"
Write-Host "-------------------------------------------"
docker pull postgres
docker run -d --name post01-postgres -e POSTGRES_PASSWORD=Password -v ${HOME}/post01-postgres/:/var/lib/postgresql/data -p 5433:5432 postgres # HOME = user directory in Windows

# pgdamin4
Write-Host "---------------------------------------------"
Write-Host "2. Create Postgres Container 'post01-pgadmin'"
Write-Host "---------------------------------------------"
docker pull dpage/pgadmin4
docker run -p 81:80 -e 'PGADMIN_DEFAULT_EMAIL=x@gmail.com' -e 'PGADMIN_DEFAULT_PASSWORD=Password' --name post01-pgadmin -d dpage/pgadmin4

# inspection
Write-Host "----------"
Write-Host "3. Inspect"
Write-Host "----------"
Start-Sleep -Seconds 20 # Replace by detecting database is 'up'
docker exec post01-postgres ls /var/lib/postgresql/data
docker exec -tiu postgres post01-postgres psql -c '\l+'
docker inspect post01-postgres -f "{{json .NetworkSettings.Networks }}"
docker inspect -f "{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}" post01-postgres

# done
Write-Host "-------"
Write-Host "4. Done"
Write-Host "-------"

Pause
