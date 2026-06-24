/*
=============================================
Stored Procedure: Load Data into Bronze Layer
=============================================

Script Purpose:
This stored procedure loads raw CRM and ERP source data into
the Bronze layer tables of the Data Warehouse.

```
The procedure performs the following tasks:
- Truncates existing data from Bronze tables.
- Loads fresh data from CSV source files using BULK INSERT.
- Separately processes CRM and ERP source datasets.
- Records and displays the execution time for each table load.
- Measures the total batch execution duration.
- Provides progress messages during execution.
- Implements error handling using TRY...CATCH blocks to capture
  and report loading errors.

This procedure serves as the initial data ingestion process,
ensuring that the Bronze layer always contains the latest raw
data from the source systems.
```

---

Source Systems:
• CRM Data Files
• ERP Data Files

Target Tables:
• bronze.crm_cust_info
• bronze.crm_prd_info
• bronze.crm_sales_details
• bronze.erp_cust_az12
• bronze.erp_loc_a101
• bronze.erp_px_cat_g1v2
------------------------

*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
	SET @batch_start_time = GETDATE();
		PRINT '====================================';
		PRINT 'Loading Bronze Layer';
		PRINT '====================================';
	
		PRINT '------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------';
	
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.crm_cust_info<<';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>>Inserting Data Into: bronze.crm_cust_info<<';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\pc\Downloads\Barra (Ex-Mercedes data scientist)\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT 'Load Duration = ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		PRINT '-------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.crm_prd_info<<';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>>Inserting Data Into: bronze.crm_prd_info<<';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\pc\Downloads\Barra (Ex-Mercedes data scientist)\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT 'Load Duration = ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		PRINT '-------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.crm_sales_details<<';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>>Inserting Data Into: bronze.crm_sales_details<<';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\pc\Downloads\Barra (Ex-Mercedes data scientist)\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT 'Load Duration = ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		PRINT '-------------------------------';

		PRINT '------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '------------------------------------';
	
		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.erp_cust_az12<<';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>>Inserting Data Into: bronze.erp_cust_az12<<';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\pc\Downloads\Barra (Ex-Mercedes data scientist)\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT 'Load Duration = ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		PRINT '-------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.erp_loc_a101<<';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>>Inserting Data Into: bronze.erp_loc_a101<<';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\pc\Downloads\Barra (Ex-Mercedes data scientist)\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT 'Load Duration = ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		PRINT '-------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.erp_px_cat_g1v2<<';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>>Inserting Data Into: bronze.erp_px_cat_g1v2<<';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\pc\Downloads\Barra (Ex-Mercedes data scientist)\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT 'Load Duration = ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		PRINT '-------------------------------';

		SET @batch_end_time = GETDATE();
		PRINT '==========================================';
		PRINT 'Loading Bronze Layer is Completed';
		PRINT 'Batch Loading Duration ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR);
		PRINT '==========================================';
	END TRY
	BEGIN CATCH
		PRINT '==============================================';
		PRINT 'Error Happened During Loading Bronze Layer';
		PRINT 'Error Message ' + ERROR_MESSAGE();
		PRINT 'Error Number ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '==============================================';
	END CATCH
END
