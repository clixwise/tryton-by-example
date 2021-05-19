# tryt11
# Execute as ./"Tryton 6.0 - Doc 05.01 - Basic Entities.import.tryt11.countries"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
#
Write-Host "---------"
Write-Host "1. Import"
Write-Host "---------"
docker exec --interactive --tty tryt11 /entrypoint.sh python3 -m trytond.modules.currency.scripts.import_currencies -d tryt11
#
Write-Host "-------"
Write-Host "2. Done"
Write-Host "-------"
Pause