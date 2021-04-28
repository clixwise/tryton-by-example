Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
docker stop dev-postgres dev-pgadmin
docker stop tryt20-postgres tryt20 tryt20-cron
docker ps -a
Pause