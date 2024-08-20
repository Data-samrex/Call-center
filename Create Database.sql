
--delete db if it exists
IF DB_ID('Callcenterdb') IS NOT NULL	--check if db exists
	DROP DATABASE [Callcenterdb]
GO

--create db
IF DB_ID('Callcenterdb') IS NULL		--check if db does not exists
	CREATE DATABASE [Callcenterdb]
GO

