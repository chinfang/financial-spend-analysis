// Given an individual supplier s, how many suppliers supply in each of its ExpenseTypes?
MATCH (type)-[:SUPPLIED_BY]->(supplier {name:"FOREIGN AND COMMONWEALTH OFFICE (FCO)"})
MATCH p=(type)-[r:SUPPLIED_BY]->(suppliers)
RETURN distinct type, count(r) as Outdegree, p
ORDER BY Outdegree DESC;

// Which individual supplier has the most unique ExpenseTypes? Which has the least unique?
MATCH p=(n:Type)-[r]-()
RETURN n, count(distinct r) as degree
ORDER BY degree, n.name;

// How do two suppliers compare in terms of competitivity?
// Create an Supplier competitivity network
CREATE CONSTRAINT ON (s1:Supplier1) ASSERT s1.name IS UNIQUE;
CREATE CONSTRAINT ON (s2:Supplier2) ASSERT s2.name IS UNIQUE;
// Load .csv file
USING PERIODIC COMMIT 100000
LOAD CSV WITH HEADERS FROM
'file:///daily3/all/1-12.csv' AS line
// Create nodes
MERGE (supplier1:Supplier1 {name: TRIM(line.`supplier1`)})
MERGE (supplier2:Supplier2 {name: TRIM(line.`supplier2`)})
// Create temporal relationships
CREATE (supplier1)-[:COMPETE {type: TRIM(line.`type1`),
t1: TOINT(TRIM(line.`date1`)),
t2: TOINT(TRIM(line.`date2`))}]
->(supplier2);

// What is the shortest path between two suppliers?
MATCH p=shortestPath((a)-[:COMPETE*]-(c))
WHERE a.name='(SEPA) SCOTTISH ENVIRONMENT PROTECTION AGENCY' and c.name='BIOTECHNOLOGY AND BIOLOGICAL SCIENCE RESEARCH COUNCIL'
RETURN p, length(p);
