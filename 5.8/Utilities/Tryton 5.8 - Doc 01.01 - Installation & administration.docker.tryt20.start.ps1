Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
docker start dev-postgres dev-pgadmin
docker start tryt20-postgres tryt20 tryt20-cron
docker ps -a
Pause