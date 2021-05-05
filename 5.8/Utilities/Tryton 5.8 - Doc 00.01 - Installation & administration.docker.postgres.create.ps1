Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

# d01-postgres
# d01-pgadmin
# 80:80
# 5432:5432

# postgres
Write-Host "-------------------------------------------"
Write-Host "1. Create Postgres Container 'd01-postgres'"
Write-Host "-------------------------------------------"
docker pull postgres
docker run -d --name d01-postgres -e POSTGRES_PASSWORD=Password -v ${HOME}/d01-postgres-data/:/var/lib/postgresql/data -p 5432:5432 postgres # HOME = user directory in Windows

# pgdamin4
Write-Host "------------------------------------------"
Write-Host "2. Create Postgres Container 'd01-pgadmin'"
Write-Host "------------------------------------------"
docker pull dpage/pgadmin4
docker run -p 80:80 -e 'PGADMIN_DEFAULT_EMAIL=x@gmail.com' -e 'PGADMIN_DEFAULT_PASSWORD=Password' --name d01-pgadmin -d dpage/pgadmin4

# inspection
Write-Host "----------"
Write-Host "3. Inspect"
Write-Host "----------"
Start-Sleep -Seconds 20 # Replace by detecting database is 'up'
docker exec d01-postgres ls /var/lib/postgresql/data
docker exec -tiu postgres d01-postgres psql -c '\l+'
docker inspect d01-postgres -f "{{json .NetworkSettings.Networks }}"
docker inspect -f "{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}" d01-postgres

# done
Write-Host "-------"
Write-Host "4. Done"
Write-Host "-------"

Pause
