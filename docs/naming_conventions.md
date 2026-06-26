# Naming Conventions

## Purpose

This document defines the naming standards used throughout the data warehouse. Consistent naming conventions improve readability, maintainability, and collaboration while ensuring that database objects remain intuitive and easy to understand.

---

# Table of Contents

1. [General Principles](#general-principles)
2. [Table Naming Conventions](#table-naming-conventions)

   * [Bronze Layer](#bronze-layer)
   * [Silver Layer](#silver-layer)
   * [Gold Layer](#gold-layer)
3. [Column Naming Conventions](#column-naming-conventions)

   * [Surrogate Keys](#surrogate-keys)
   * [Technical Columns](#technical-columns)
4. [Stored Procedure Naming Conventions](#stored-procedure-naming-conventions)

---

# General Principles

The following standards apply to all database objects.

* Use **snake_case** with lowercase letters and underscores (`_`) to separate words.
* Use **English** for all object names.
* Use clear and descriptive names.
* Avoid abbreviations unless they are widely recognized.
* Avoid SQL reserved keywords as object names.
* Maintain consistency across all layers of the data warehouse.

---

# Table Naming Conventions

## Bronze Layer

Bronze tables represent raw data ingested from source systems.

### Naming Pattern

```text
<source_system>_<entity>
```

| Component         | Description                                    |
| ----------------- | ---------------------------------------------- |
| `<source_system>` | Source system name (for example, `crm`, `erp`) |
| `<entity>`        | Original table name from the source system     |

### Rules

* Preserve the original source table names.
* Do not rename entities during ingestion.
* Prefix each table with the source system name.

### Examples

| Table Name          | Description                              |
| ------------------- | ---------------------------------------- |
| `crm_customer_info` | Customer information from the CRM system |
| `erp_sales_orders`  | Sales orders from the ERP system         |

---

## Silver Layer

Silver tables contain cleansed, standardized, and transformed data.

### Naming Pattern

```text
<source_system>_<entity>
```

| Component         | Description          |
| ----------------- | -------------------- |
| `<source_system>` | Source system name   |
| `<entity>`        | Original entity name |

### Rules

* Preserve source system identifiers.
* Apply data cleansing and transformation without changing table names.
* Maintain lineage between Bronze and Silver layers.

### Examples

| Table Name          | Description                   |
| ------------------- | ----------------------------- |
| `crm_customer_info` | Cleansed customer data        |
| `erp_sales_orders`  | Standardized sales order data |

---

## Gold Layer

Gold tables represent business-ready data models designed for reporting and analytics.

### Naming Pattern

```text
<category>_<entity>
```

| Component    | Description                                    |
| ------------ | ---------------------------------------------- |
| `<category>` | Table classification (`dim`, `fact`, `report`) |
| `<entity>`   | Business entity name                           |

### Rules

* Use business-friendly terminology.
* Name tables according to their analytical purpose.
* Apply dimensional modeling standards.

### Examples

| Table Name             | Description                   |
| ---------------------- | ----------------------------- |
| `dim_customers`        | Customer dimension table      |
| `dim_products`         | Product dimension table       |
| `fact_sales`           | Sales fact table              |
| `report_sales_monthly` | Monthly sales reporting table |

---

## Category Prefix Glossary

| Prefix    | Description      | Examples                        |
| --------- | ---------------- | ------------------------------- |
| `dim_`    | Dimension tables | `dim_customers`, `dim_products` |
| `fact_`   | Fact tables      | `fact_sales`                    |
| `report_` | Reporting tables | `report_sales_monthly`          |

---

# Column Naming Conventions

## Surrogate Keys

Dimension tables use surrogate keys to uniquely identify records.

### Naming Pattern

```text
<entity>_key
```

### Rules

* Use the `_key` suffix for all surrogate keys.
* Surrogate keys should be integer values.
* Foreign keys in fact tables should reference the corresponding dimension key.

### Examples

| Column Name    | Description                 |
| -------------- | --------------------------- |
| `customer_key` | Surrogate key for customers |
| `product_key`  | Surrogate key for products  |

---

## Technical Columns

Technical and audit columns must use the `dwh_` prefix.

### Naming Pattern

```text
dwh_<column_name>
```

### Rules

* Reserve the `dwh_` prefix for system-generated metadata.
* Use these columns for auditing, lineage, and operational monitoring.

### Examples

| Column Name         | Description              |
| ------------------- | ------------------------ |
| `dwh_load_date`     | Record load date         |
| `dwh_update_date`   | Last update timestamp    |
| `dwh_source_system` | Source system identifier |

---

# Stored Procedure Naming Conventions

Stored procedures responsible for data loading should follow a consistent naming standard.

### Naming Pattern

```text
load_<layer>
```

| Component | Description                      |
| --------- | -------------------------------- |
| `load`    | Indicates a data loading process |
| `<layer>` | Target data warehouse layer      |

### Examples

| Procedure Name | Description                      |
| -------------- | -------------------------------- |
| `load_bronze`  | Loads data into the Bronze layer |
| `load_silver`  | Loads data into the Silver layer |
| `load_gold`    | Loads data into the Gold layer   |

---

# Summary

| Object Type       | Naming Standard            |
| ----------------- | -------------------------- |
| Bronze Tables     | `<source_system>_<entity>` |
| Silver Tables     | `<source_system>_<entity>` |
| Gold Tables       | `<category>_<entity>`      |
| Surrogate Keys    | `<entity>_key`             |
| Technical Columns | `dwh_<column_name>`        |
| Stored Procedures | `load_<layer>`             |

These conventions promote consistency, improve maintainability, and simplify data warehouse development and governance.
