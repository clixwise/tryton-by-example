Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
#
docker exec -tiu postgres tryt20-postgres psql -c '\l+'
# Step 1.1 : dump tryt02
docker exec tryt20-postgres pg_dump -Ft -U postgres -O -f tryt20-db-backup.tar tryt20
# Step 1.2 : export outside container (optional ; specifically use if later import in another container)
docker cp tryt20-postgres:/tryt20-db-backup.tar tryt20-db-backup.tar
Pause