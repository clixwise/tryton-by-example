# tryt20
# Execute as ./"Tryton 5.8 - Doc 05.01 - Basic Entities.import.tryt20.countries"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
docker exec --interactive --tty tryt20 /entrypoint.sh python3 -m trytond.modules.currency.scripts.import_currencies -d tryt20
Pause