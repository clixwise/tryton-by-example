Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
# Step 1 : docker stop/start containers
docker stop tryt20-postgres tryt20
docker start tryt20-postgres tryt20
# Step 2 : state
docker ps -a
Start-Sleep -Seconds 10
docker exec -tiu postgres tryt20-postgres psql -c '\l+'
# Step 3 : drop and create tryt20-copy
docker exec tryt20-postgres dropdb -f -U postgres tryt20-copy
docker exec tryt20-postgres createdb -U postgres -T template0 tryt20-copy
# Step 4.1 : import inside container (optional ; function of step 1.2 above)
docker cp tryt20-db-backup.tar tryt20-postgres:/tryt20-db-backup.tar
# Step 4.2 : restore tryt20-copy from tryt20
docker exec -i tryt20-postgres pg_restore -Ft -U postgres -d tryt20-copy -v ./tryt20-db-backup.tar
# Step 5 : state
docker exec -tiu postgres tryt20-postgres psql -c '\l+'
Pause
