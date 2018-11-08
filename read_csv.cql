// create the relationships between transaction and supplier, area, type.
CREATE CONSTRAINT ON (t:Type) ASSERT t.name IS UNIQUE;
CREATE CONSTRAINT ON (a:Area) ASSERT a.name IS UNIQUE;
CREATE CONSTRAINT ON (s:Supplier) ASSERT s.name IS UNIQUE;
// load CSV file
USING PERIODIC COMMIT 100000
LOAD CSV WITH HEADERS FROM
'file:///AllData-2011-2016v05.csv' AS line
// create the transaction nodes
CREATE (transaction:Transaction {year: TOINT(line.Year), month: TOINT(line.Month),
day: TOINT(line.Day),
number: TOINT(line.`TransactionNumber`),
amount: TOINT(line.`Amount`)})
// create area, type, supplier nodes
MERGE (area:Area {name: line.`ExpenseArea`})
MERGE (type:Type {name: line.`ExpenseType`})
MERGE (supplier:Supplier {name: line.Supplier})
// create transaction relationships
CREATE (transaction)-[:IN]->(area)
CREATE (transaction)-[:OF]->(type)
CREATE (transaction)-[:TO]->(supplier)
;
