/*
===================================================================
Create Database and Schemas
===================================================================
Script Purpose: 
	This script creates a new database named 'DataWarehouse' after checking if it already exists. 
	If the database exists, it will be dropped and recreated. Additionally, the script creates three schemas 
	within the 'DataWarehouse' database: 'bronze', 'silver', and 'gold'.

WARNINGS: 
	Running this script will drop the entire 'DataWarehouse' database if it exists. 
	All data in the database will be permanently deleted. Proceed with caution 
	and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database if it already exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create SCHEMAS --> Bronze, Silver, Gold (DataWarehouse > Security > Schemas)

CREATE SCHEMA bronze;
GO

-- Continue creating these two SCHEMAS altogether: silver and gold
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO

-- You can utilize below code to enhance the previous code starting from line 34 to 43
-- Create SCHEMAS --> Bronze, Silver, Gold (only if they don't already exist)
BEGIN TRY
	IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'bronze')
		EXEC('CREATE SCHEMA bronze');
	IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'silver')
		EXEC('CREATE SCHEMA silver');
	IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'gold')
		EXEC('CREATE SCHEMA gold');
END TRY
BEGIN CATCH
	PRINT CONCAT('Schema creation failed: ', ERROR_MESSAGE());
	THROW;
END CATCH;
GO
