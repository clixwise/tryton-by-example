Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
#
Write-Host "---------"
Write-Host "1. Status"
Write-Host "---------"
docker exec -tiu postgres tryt01-postgres psql -c '\l+'

# Step 2 : dump tryt01
Write-Host "-------"
Write-Host "2. Dump"
Write-Host "-------"
docker exec tryt01-postgres pg_dump -Ft -U postgres -O -f tryt01-db-backup.tar tryt01

# Step 3 : export outside container (optional ; specifically use if later import in another container)
Write-Host "---------------------------------"
Write-Host "3. Export 'tar' outside container"
Write-Host "---------------------------------"
docker cp tryt01-postgres:/tryt01-db-backup.tar tryt01-db-backup.tar

#
Write-Host "-------"
Write-Host "4. Done"
Write-Host "-------"
Pause