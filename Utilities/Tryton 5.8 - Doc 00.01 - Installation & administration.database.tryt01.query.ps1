#
# Query database
#

# container : tryt01-postgres
# database  : tryt01
#
# input and output files :
# query.dbms_01 : list of tables with row count
# query.dbms_02 : list of pk-fk relationships
# query.res_user : list of 'res_user' table (example)

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
Set-PSDebug -Trace 1
Set-PSDebug -Off
#
Write-Host "---------"
Write-Host "1. Access"
Write-Host "---------"
docker cp query.dbms_01.sql tryt01-postgres:/inpu.sql
docker exec -it tryt01-postgres psql -d tryt01 -U postgres -P pager=off -f inpu.sql -o outp.txt
docker cp tryt01-postgres:/outp.txt query.dbms_01.txt
#
Write-Host "-------"
Write-Host "2. Done"
Write-Host "-------"

