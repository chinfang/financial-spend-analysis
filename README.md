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
We first have a general view of the transaction period to each supplier. The figure shows that some of the expense types 
have lots of variation in transaction period of each supplier, while some of the expense types have very consistent transaction
period. The result represents that each supplier has very different transaction period.

<p align="center">
  <img width="544" src="https://raw.githubusercontent.com/slundberg/shap/master/docs/artwork/boston_dependence_plot.png" />
</p>
