## **E-commerce Project**
### Project Overview

This project simulates an **E-commerce business** that manages customers, products, orders, and order items.

Using **dbt** and **Databricks**, the project transforms raw business data into structured and reliable datasets for analytics and reporting, helping the business understand sales, customer, and product performance.


### Architecture

The project follows the **Medallion Architecture**:

* **Bronze:** Raw E-commerce data loaded from CSV files
* **Silver:** Cleaned and transformed data
* **Gold:** Analytics-ready data for reporting and analysis


**Data Flow:**
`CSV → Bronze → Silver → Gold`


### Main Models
* `fct_orders` — Order-level data
* `fct_order_items` — Order item-level data
* `dim_products` — Product information
* `scd_customers` — Customer history using Type 2 SCD

### Key Implementations
- Data Modeling
- Incremental Models
- Type 2 SCD using dbt Snapshots
- Data Quality Tests
- dbt Exposures
- dbt Documentation


### Project Structure 
```text
DBT_Databricks_project/
│
├── models/
│   ├── staging/
│   ├── intermediate/
│   └── marts/
│
├── seeds/
├── snapshots/
├── tests/
├── macros/
│
└── dbt_project.yml
```
  
### Tech Stack
* **dbt**
* **Databricks**
* **SQL**



