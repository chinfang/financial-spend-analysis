# Analyse financial spend using Neo4j in British Government spending dataset
The goal of this project is to investigate the time evolution of expenses and the competitivity between suppliers. 

### Dataset
The [British Government spending over £25,000 in the Department for Business, Innovation and Skills](https://data.gov.uk/dataset/22a8f668-9cf5-43b6-b097-8be0303ad74d/spend-over-25-000-in-the-department-for-business-innovation-and-skills)
dataset contains more than 500,000 records of information from January 2011 until January 2016, this are available in 61 different files. 
The content inluding: departments, expense types, expense areas, suppliers, spent amount and date of payments.

### Models and Techniques
Graph database: [Neo4j](https://neo4j.com)
Visualization: [Tableau](https://www.tableau.com)

### Analysis and Results
We first have a general view of the transaction period to each supplier. The plot below shows that some of the expense types 
have lots of variation in transaction period of each supplier, while some of the expense types have very consistent transaction
period. The result represents that each supplier has very different transaction period.

<p align="center">
  <img width="544" src="https://github.com/chinfang/financial-spend-analysis/blob/master/img/transaction_period.png" />
</p>

Since the transaction period and transaction amount vary a lot between suppliers, the money stream density is calculated by "total transaction amount/transaction times" for each supplier. The plot below shows the five suppliers (yellow nodes) with the highest stream density and their expense types (grey nodes). "Skills Funding Agency" involved in lots of expense types and has biggest money stream density, while there are some suppliers only involved in one or two expense types. Therefore, this result brings us the upcoming question that which suppliers might be the competitors of "Skills Funding Agency".

<p align="center">
  <img width="544" src="https://github.com/chinfang/financial-spend-analysis/blob/master/img/biggest_money_stream_density.png" />
</p>

The plot below shows the competitors of supplier "Skills funding agency". The query is performed to find the expense types that supplied by this supplier, then searched for other suppliers that also supplied in those expense types. As shown in the middle of the figure, "Skill funding agency" is supplied in 15 expense types. While the other competitors only supplied in less than eight expense types. The result is obvious that "Skill funding agency" supplied in lots of expense types and has the biggest money stream density.

<p align="center">
  <img width="544" src="https://github.com/chinfang/financial-spend-analysis/blob/master/img/competitors.png" />
</p>

