Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
#
Write-Host "---------"
Write-Host "1. Status"
Write-Host "---------"
docker exec -tiu postgres post01-postgres psql -c '\l+'

#
Write-Host "-------"
Write-Host "2. Dump"
Write-Host "-------"
docker exec post01-postgres pg_dump -C -c -U postgres -O -f post01-db-backup.createYes.sql postgres # includes database create commands
docker exec post01-postgres pg_dump    -c -U postgres -O -f post01-db-backup.createNot.sql postgres # coes not include such commands
docker exec post01-postgres pg_dump -Fc   -U postgres -O -f post01-db-backup.bak postgres
docker exec post01-postgres pg_dump -Ft   -U postgres -O -f post01-db-backup.tar postgres
docker exec post01-postgres ls -l

#
Write-Host "---------------------------------"
Write-Host "3. Export 'tar' outside container"
Write-Host "---------------------------------"
docker cp post01-postgres:/post01-db-backup.createYes.sql post01-db-backup.createYes.sql
docker cp post01-postgres:/post01-db-backup.createNot.sql post01-db-backup.createNot.sql
docker cp post01-postgres:/post01-db-backup.bak post01-db-backup.bak
docker cp post01-postgres:/post01-db-backup.tar post01-db-backup.tar
ls

#
Write-Host "-------"
Write-Host "4. Done"
Write-Host "-------"
Pause