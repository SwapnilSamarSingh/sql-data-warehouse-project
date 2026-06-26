# Data Catalog for Gold Layer

## Overview

The **Gold Layer** represents the business-ready data model designed to support reporting, dashboards, and analytical use cases. It contains curated **dimension tables** and **fact tables** that provide consistent, reliable, and business-friendly data for analysis and decision-making.

---

## 1. `gold.dim_customers`

**Purpose:**
Stores customer information enriched with demographic and geographic attributes to support customer analytics and segmentation.

### Columns

| Column Name       | Data Type    | Description                                                                         |
| ----------------- | ------------ | ----------------------------------------------------------------------------------- |
| `customer_key`    | INT          | Surrogate key that uniquely identifies each customer record in the dimension table. |
| `customer_id`     | INT          | Unique business identifier assigned to each customer.                               |
| `customer_number` | NVARCHAR(50) | Alphanumeric customer identifier used for business tracking and reference purposes. |
| `first_name`      | NVARCHAR(50) | Customer's first name as recorded in the source system.                             |
| `last_name`       | NVARCHAR(50) | Customer's last name or family name.                                                |
| `country`         | NVARCHAR(50) | Country of residence of the customer (for example, Australia).                      |
| `marital_status`  | NVARCHAR(50) | Marital status of the customer (for example, Married or Single).                    |
| `gender`          | NVARCHAR(50) | Gender of the customer (for example, Male, Female, or N/A).                         |
| `birthdate`       | DATE         | Customer's date of birth in `YYYY-MM-DD` format.                                    |
| `create_date`     | DATE         | Date on which the customer record was created in the source system.                 |

---

## 2. `gold.dim_products`

**Purpose:**
Stores product-related information and descriptive attributes used for product analysis and reporting.

### Columns

| Column Name            | Data Type    | Description                                                                                  |
| ---------------------- | ------------ | -------------------------------------------------------------------------------------------- |
| `product_key`          | INT          | Surrogate key that uniquely identifies each product record in the dimension table.           |
| `product_id`           | INT          | Unique business identifier assigned to the product.                                          |
| `product_number`       | NVARCHAR(50) | Alphanumeric product code used for identification, inventory management, and tracking.       |
| `product_name`         | NVARCHAR(50) | Descriptive name of the product, including relevant attributes such as type, color, or size. |
| `category_id`          | NVARCHAR(50) | Identifier representing the product category.                                                |
| `category`             | NVARCHAR(50) | High-level product classification (for example, Bikes or Components).                        |
| `subcategory`          | NVARCHAR(50) | Detailed product classification within a category.                                           |
| `maintenance_required` | NVARCHAR(50) | Indicates whether the product requires maintenance (for example, Yes or No).                 |
| `cost`                 | INT          | Standard cost or base cost of the product in monetary units.                                 |
| `product_line`         | NVARCHAR(50) | Product line or series to which the product belongs (for example, Road or Mountain).         |
| `start_date`           | DATE         | Date when the product became available for sale or active use.                               |

---

## 3. `gold.fact_sales`

**Purpose:**
Stores sales transaction data used for revenue analysis, sales reporting, and business performance measurement.

### Columns

| Column Name     | Data Type    | Description                                                                |
| --------------- | ------------ | -------------------------------------------------------------------------- |
| `order_number`  | NVARCHAR(50) | Unique sales order identifier (for example, `SO54496`).                    |
| `product_key`   | INT          | Foreign key referencing the associated product in the product dimension.   |
| `customer_key`  | INT          | Foreign key referencing the associated customer in the customer dimension. |
| `order_date`    | DATE         | Date on which the order was placed.                                        |
| `shipping_date` | DATE         | Date on which the order was shipped to the customer.                       |
| `due_date`      | DATE         | Payment due date associated with the order.                                |
| `sales_amount`  | INT          | Total sales amount for the order line in monetary units.                   |
| `quantity`      | INT          | Number of product units sold in the order line.                            |
| `price`         | INT          | Unit selling price of the product in monetary units.                       |

---

## Data Model Summary

| Table                | Type      | Description                                      |
| -------------------- | --------- | ------------------------------------------------ |
| `gold.dim_customers` | Dimension | Customer demographic and geographic information. |
| `gold.dim_products`  | Dimension | Product attributes and classifications.          |
| `gold.fact_sales`    | Fact      | Sales transactions and performance metrics.      |

### Design Principles

* **Dimension tables** provide descriptive business attributes.
* **Fact tables** store measurable business events and transactional data.
* **Surrogate keys** are used to maintain consistency and support dimensional modeling.
* The model follows a **star schema design** to optimize reporting and analytical workloads.
