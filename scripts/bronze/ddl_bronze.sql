/*

======================================
DDL Script: Create Bronze Layer Tables
======================================

Script Purpose:
This script creates the source tables in the Bronze layer of the
Data Warehouse. Before creating each table, the script checks
whether the table already exists and drops it if necessary to
ensure a clean and consistent setup.

```
The tables created in this script store raw CRM and ERP data,
serving as the initial data ingestion layer before data cleansing
and transformation processes in the Silver and Gold layers.
```

-----------------------

Tables Created:
• bronze.crm_cust_info
• bronze.crm_prd_info
• bronze.crm_sales_details
• bronze.erp_loc_a101
• bronze.erp_cust_az12
• bronze.erp_px_cat_g1v2
------------------------

*/

IF OBJECT_ID ('bronze.crm_cust_info', 'u') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;

GO

CREATE TABLE bronze.crm_cust_info (
	cst_id				INT,
	cst_key				NVARCHAR(50),
	cst_firstname		NVARCHAR(50),
	cst_lastname		NVARCHAR(50),
	cst_marital_status	NVARCHAR(50),
	cst_gndr			NVARCHAR(50),
	cst_create_date		DATE
);

GO

IF OBJECT_ID ('bronze.crm_prd_info', 'u') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info (
	prd_id			INT,
	prd_key			NVARCHAR(50),
	prd_nm			NVARCHAR(50),
	prd_cost		INT,
	prd_line		NVARCHAR(50),
	prd_start_dt	DATETIME,
	prd_end_dt		DATETIME
);

GO

IF OBJECT_ID ('bronze.crm_sales_details', 'u') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details (
	sls_ord_num		NVARCHAR(50),
	sls_prd_key		NVARCHAR(50),
	sls_cust_id		INT,
	sls_odr_dt		INT,
	sls_ship_dt		INT,
	sls_due_dt		INT,
	sls_sales		INT,
	sls_quantity	INT,
	sls_price		INT
);

GO

IF OBJECT_ID ('bronze.erp_loc_a101', 'u') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;

GO

CREATE TABLE bronze.erp_loc_a101 (
	cid		NVARCHAR(50),
	cntry	NVARCHAR(50)
);

GO

IF OBJECT_ID ('bronze.erp_cust_az12', 'u') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;

GO

CREATE TABLE bronze.erp_cust_az12 (
	cid		NVARCHAR(50),
	bdate	DATE,
	gen		NVARCHAR(50)
);

GO

IF OBJECT_ID ('bronze.erp_px_cat_g1v2', 'u') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;

GO

CREATE TABLE bronze.erp_px_cat_g1v2 (
	id			NVARCHAR(50),
	cat			NVARCHAR(50),
	subcat		NVARCHAR(50),
	maintanance NVARCHAR(50)
	);

GO
