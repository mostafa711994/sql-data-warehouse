-- ============================================================================
-- Script: init_database.sql
-- Purpose: Initialize the DataWareHouse database with medallion architecture
-- Summary: 
--   This script performs a complete reset of the DataWareHouse database by:
--   1. Dropping the existing database if it exists (with forced disconnection)
--   2. Creating a fresh DataWareHouse database
--   3. Setting up the medallion architecture schemas (bronze, silver, gold)
-- ============================================================================

-- Switch to master database to perform database-level operations
use master;
GO

-- Drop existing DataWareHouse database if it exists
IF EXISTS( select 1 from sys.databases where name='DataWareHouse')
BEGIN
	-- Force disconnect all users and rollback their transactions
	ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	-- Drop the database
	DROP DATABASE DataWareHouse;
END;
GO

-- Create a new DataWareHouse database
CREATE database DataWareHouse;
GO

-- Switch to the newly created DataWareHouse database
use DataWareHouse;
GO

-- Create Bronze schema: Raw data layer
CREATE SCHEMA bronze;
GO

-- Create Silver schema: Cleaned data layer
CREATE SCHEMA silver;
GO

-- Create Gold schema: Curated data layer
CREATE SCHEMA gold;
GO