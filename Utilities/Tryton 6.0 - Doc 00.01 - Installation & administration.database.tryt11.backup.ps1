#
# tryt11
# tryt11-postgres
# tryt11-db-backup.tar
#
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

Write-Host "---------"
Write-Host "1. Status"
Write-Host "---------"
docker exec -tiu postgres tryt11-postgres psql -c '\l+'

# Step 2 : dump tryt11
Write-Host "-------"
Write-Host "2. Dump"
Write-Host "-------"
docker exec tryt11-postgres pg_dump -Ft -U postgres -O -f tryt11-db-backup.tar tryt11

# Step 3 : export outside container (optional ; specifically use if later import in another container)
Write-Host "---------------------------------"
Write-Host "3. Export 'tar' outside container"
Write-Host "---------------------------------"
docker cp tryt11-postgres:/tryt11-db-backup.tar tryt11-db-backup.tar

#
Write-Host "-------"
Write-Host "4. Done"
Write-Host "-------"
Pause