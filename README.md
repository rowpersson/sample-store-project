Hello!
Welcome my dbt project for the fake API online store (https://fakestoreapi.com/docs).
You can find all of the relevant models in the dbt-project folder, while the source Python scripts used to load sample data into BigQuery can be found in the data-pipeline folder.

### Conceptualizing the data warehouse structure

The dbt project takes shape using this folder and file structure:
```bash
/sample-store-project
├── /data-pipeline
├── /dbt-project
│ ├── /models
│ │ ├── /marts
│ │ │ ├── /analytics
│ │ │ │ ├── monthly_sales.sql
│ │ │ │ ├── top_selling_products.sql
│ │ │ ├── /core
│ │ │ │ ├── customer_order_summary.sql
│ │ │ │ ├── order_details.sql
│ │ │ │ ├── product_sales.sql  
│ │ │ ├── /reporting  
│ │ │ │ ├── order_level_report.sql
│ │ ├── /staging
│ │ │ ├── sources.yml
│ │ │ ├── stg_carts.sql
│ │ │ ├── stg_products.sql
│ │ │ ├── stg_users.sql
│ │ ├── /seeds
│ │ ├── /snapshots
│ │ ├── /tests  
│ │ │ ├── carts_data_quality.sql
│ │ │ ├── product_data_quality.sql
│ │ │ ├── users_data_quality.sql
├── dbt_project.yml  
├── profiles.yml
```
Some details:
- models/staging: this folder contains the staging tables used to pull from the raw data tables using some light transformations.
- models/marts: this folder contains analyses done on the staging tables.
  - models/marts/analytics: this folder contains any ad-hoc analytics or compelling data points about the data that might be helpful on a time series.
  - models/marts/core: this folder holds the main type of details that summarize the store data.
  - models/marts/reporting: this folder holds the final reporting table/view that summarizes order-level information
- seeds: this folder is to hold any extra static information (e.g., credit card providers, payment options)
- snapshots: this folder is to hold any timestamped information (e.g., month end data)
- tests: this folder contains the data quality tests for each of the source tables

### Ensuring data quality, documentation, testing, and performance

- To ensure high-quality data, we will enforce several data quality tests across our DBT models. This will include: not null checks, referential integrity, uniqueness tests, and validity tests. I have created a few examples for each of the staging tables.
- DBT allows us to document models using the description field in the model files (please see the dbt_project.yml file for examples). Additionally, each field can be documented using the meta tag.
- For testing, we could use DBT's built-in testing features to apply not_null, unique, and accepted_values tests to relevant fields. We also can define custom SQL tests for more specific checks, such as price ranges or column value validity.
- To optimize for performance and cost, we can implement the following practices:
  - Incremental models: For large tables, we could use incremental models so that only new data is processed rather than reprocessing the entire table.
  - Partitioning: For large fact tables, we can partition the table by a date field (transaction_date) to improve query performance and reduce costs.
  - Clustering: We can use clustering on frequently filtered columns such as user_id and product_id to further improve query performance.
  - Avoiding unnecessary joins: In the staging and intermediate models, only join tables when absolutely necessary. This reduces the complexity and cost of the models.

### Creating a final order-level fact table

- I have implemented a star schema approach to create the final order-level table. The final order_level_report table can be used to run BI reports off of. The lineage looks like this:

<img width="962" alt="Screenshot 2025-01-26 at 5 26 51 PM" src="https://github.com/user-attachments/assets/9f05907e-f58c-48cf-8b16-91a8d2ddbf4c" />

