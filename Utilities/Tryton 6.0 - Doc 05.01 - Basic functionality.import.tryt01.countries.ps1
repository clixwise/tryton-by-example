# tryt01
# Execute as ./"Tryton 5.8 - Doc 05.01 - Basic Entities.import.tryt01.countries"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
#
Write-Host "---------"
Write-Host "1. Import"
Write-Host "---------"
docker exec --interactive --tty tryt01 /entrypoint.sh python3 -m trytond.modules.country.scripts.import_countries -d tryt01
#
Write-Host "-------"
Write-Host "2. Done"
Write-Host "-------"
Pause
