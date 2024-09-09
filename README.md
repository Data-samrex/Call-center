# Bluiding a Database solution for a call centre

### ENTITY-RELATIONSHIP DIAGRAM (ERD)
An entity relationship diagram (ERD) serves as a comprehensive and structured depiction of data storage, showcasing the relationships and constraints that logically connect them. Its primary purpose is to organise data effectively, revealing the intricate relationships between entities within the schema. 


<img width="506" alt="ERD" src="https://github.com/user-attachments/assets/2b2d16d1-6e04-4b20-9b57-ac15c412abfc">


### CREATE DATABASE 
```sql

--delete db if it exists
IF DB_ID('Callcenterdb') IS NOT NULL	--check if db exists
	DROP DATABASE [Callcenterdb]
GO

--create db
IF DB_ID('Callcenterdb') IS NULL		--check if db does not exists
	CREATE DATABASE [Callcenterdb]
GO
```
