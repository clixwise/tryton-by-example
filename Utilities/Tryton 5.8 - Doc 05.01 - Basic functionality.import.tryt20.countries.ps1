# tryt20
# Execute as ./"Tryton 5.8 - Doc 05.01 - Basic Entities.import.tryt20.countries"
docker exec --interactive --tty tryt20 /entrypoint.sh python3 -m trytond.modules.country.scripts.import_countries -d tryt20
