// 1. Create an Expense Type and Supplier network
CREATE CONSTRAINT ON (t:Type) ASSERT t.name IS UNIQUE;
CREATE CONSTRAINT ON (a:Area) ASSERT a.name IS UNIQUE;
CREATE CONSTRAINT ON (s:Supplier) ASSERT s.name IS UNIQUE;
// Load .csv file
USING PERIODIC COMMIT 100000
LOAD CSV WITH HEADERS FROM
'file:///TypeSupplier.csv' AS line
// Create nodes
MERGE (supplier:Supplier {name: TRIM(line.`Supplier`)})
MERGE (type:Type {name: TRIM(line.`Type`)})
// Create temporal relationships
CREATE (supplier)<-[:SUPPLIED_BY {start_year: TOINT(TRIM(line.`StartYear`)),
start_month:TOINT(TRIM(line.`StartMonth`)),
start_day: TOINT(TRIM(line.`StartDay`)),
end_year: TOINT(TRIM(line.`EndYear`)),
end_month: TOINT(TRIM(line.`EndMonth`)),
end_day: TOINT(TRIM(line.`EndDay`)),
transaction_times: TOINT(TRIM(line.`TransactionTimes`)),
transaction_amount: TOINT(TRIM(line.`TransactionAmount`))}]
-(type);

// 2. Analyse the graph
// Which Expense Type had the most expense?
MATCH p=(type)-[r:SUPPLIED_BY]->(supplier)
RETURN distinct type, sum(r.transaction_amount) AS sum_transaction
ORDER BY sum_transaction DESC;
// Which Supplier has the biggest money stream density?
MATCH p=()-[r:SUPPLIED_BY]->(supplier)
RETURN p, r.transaction_amount/r.transaction_times AS stream_density
ORDER BY stream_density DESC;
// Are the competitors of "Skills funding agency" also involved in lots of expense type?
MATCH (type)-[:SUPPLIED_BY]->(supplier {name:"SKILLS FUNDING AGENCY"})
WITH distinct type
MATCH p=(type)-[r:SUPPLIED_BY]->(suppliers)
RETURN distinct suppliers, p, sum(r.transaction_amount) AS sum_trans
ORDER BY sum_trans DESC;
