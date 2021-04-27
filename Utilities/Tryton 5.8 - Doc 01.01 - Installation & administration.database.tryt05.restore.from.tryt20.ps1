# Step 1 : docker stop/start containers
docker stop tryt05-postgres tryt05
docker start tryt05-postgres tryt05
# Step 2 : state
docker ps -a
Start-Sleep -Seconds 10
docker exec -tiu postgres tryt05-postgres psql -c '\l+'
# Step 3 : drop and create tryt05
docker exec tryt05-postgres dropdb -f -U postgres tryt05
docker exec tryt05-postgres createdb -U postgres -T template0 tryt05
# Step 4.1 : import inside container (optional ; function of step 1.2 above)
docker cp tryt20-db-backup.tar tryt05-postgres:/tryt20-db-backup.tar
# Step 4.2 : restore tryt05 from tryt05
docker exec -i tryt05-postgres pg_restore -Ft -U postgres -d tryt05 -v ./tryt20-db-backup.tar
# Step 5 : state
docker exec -tiu postgres tryt05-postgres psql -c '\l+'
