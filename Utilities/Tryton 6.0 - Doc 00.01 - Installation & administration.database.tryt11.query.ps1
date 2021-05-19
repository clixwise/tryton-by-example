#
# Query database
#

# container : tryt11-postgres
# database  : tryt11
#
# input and output files :
# query.dbms_01 : list of tables with row count
# query.dbms_02 : list of pk-fk table relationships
# query.res_user : list of 'res_user' table rows (example)

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
Set-PSDebug -Trace 1
Set-PSDebug -Off
#
Write-Host "---------"
Write-Host "1. Select"
Write-Host "---------"
docker cp query.dbms_01.sql tryt11-postgres:/inpu.sql
#
Write-Host "---------"
Write-Host "2. Access"
Write-Host "---------"
docker exec -it tryt11-postgres psql -d tryt11 -U postgres -P pager=off -f inpu.sql -o outp.txt
docker cp tryt11-postgres:/outp.txt query.dbms_02.txt
#
Write-Host "-------"
Write-Host "3. Done"
Write-Host "-------"

