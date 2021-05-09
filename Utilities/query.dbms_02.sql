WITH     ta1 AS (
select FKtable, PKTable, FKcolumn,PKcolumn
from (
SELECT conrelid::regclass AS FKtable
       ,CASE WHEN pg_get_constraintdef(c.oid) LIKE 'FOREIGN KEY %' THEN substring(pg_get_constraintdef(c.oid), position(' REFERENCES ' in pg_get_constraintdef(c.oid))+12, position('(' in substring(pg_get_constraintdef(c.oid), 14))-position(' REFERENCES ' in pg_get_constraintdef(c.oid))+1) END AS PKtable
	   ,CASE WHEN pg_get_constraintdef(c.oid) LIKE 'FOREIGN KEY %' THEN substring(pg_get_constraintdef(c.oid), 14, position(')' in pg_get_constraintdef(c.oid))-14) END AS FKcolumn
       ,CASE WHEN pg_get_constraintdef(c.oid) LIKE 'FOREIGN KEY %' THEN substring(pg_get_constraintdef(c.oid), position('(' in substring(pg_get_constraintdef(c.oid), 14))+14, position(')' in substring(pg_get_constraintdef(c.oid), position('(' in substring(pg_get_constraintdef(c.oid), 14))+14))-1) END AS PKcolumn
FROM   pg_constraint c
JOIN   pg_namespace n ON n.oid = c.connamespace
WHERE  contype IN ('f', 'p ')  
AND pg_get_constraintdef(c.oid) LIKE 'FOREIGN KEY %'
) ta2
) 
,
ro1 AS (
select table_name, (xpath('/row/cnt/text()', xml_count))[1]::text::int as row_count
from (
  select table_name, table_schema, query_to_xml(format('select count(*) as cnt from %I.%I', table_schema, table_name), false, true, '') as xml_count
  from information_schema.tables
  where table_schema = 'public' --<< change here for the schema you want
  ORDER BY table_name
) ro2
)
select PKrow as "pkTableRows",FKrow as "fkTableRows",
		PKtable as "pkTable",FKtable as "fkTable",
		PKcolumn as "pkColumn",FKcolumn as "fkColumn"
from (
select 	rx2.row_count as PKrow,rx1.row_count as FKrow,
		ta1.PKtable as PKtable,ta1.FKtable as FKtable,
		ta1.PKcolumn as PKcolumn,ta1.FKcolumn as FKcolumn
FROM ta1
LEFT JOIN ro1 rx1
on CAST(rx1.table_name AS TEXT) = CAST(ta1.FKtable AS TEXT)
LEFT JOIN ro1 rx2
on CAST(rx2.table_name AS TEXT) = CAST(ta1.PKtable AS TEXT)
) as main