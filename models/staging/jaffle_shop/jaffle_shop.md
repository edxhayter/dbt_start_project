# Customer Table
{% docs src_customers %}
This table contains customers that make an order with Jaffle Shop. 
Any new customer at Jaffle_Shop is assigned an ID and their First and Last Names are recorded in respective columns
{% enddocs %}
## Customer Columns
### Customer_ID (ID)
ID is changed at staging so does not require a Doc Block
### First Name
{% docs first_name %}
The first name of the customer at Jaffle_Shop
{% enddocs %}
### Last Name
{% docs last_name %}
The last name of the customer at Jaffle_Shop
{% enddocs %}

# Orders Table
{% docs src_orders %}
This table contains a row for every order placed at Jaffle_Shop. Each order is assigned a unique order ID in the id field of the source data
{% enddocs %}
## Orders Columns
### Order_ID (ID)
ID is updated in staging to order_id for clarity so does not require a doc block.
### Customer_ID (User_ID)
User ID is updated to customer_id in staging for consistency so does not require a doc block.
### Order_date
{% docs order_date %}
Date the order is made
{% enddocs %}
### Order_status (Status)
Status is renamed to order_status so does not require a doc block
### _ETL_loaded_at
{% docs _etl_loaded_at %}
Timestamp of when the raw data was loaded into the warehouse
{% enddocs %}

# Orders Staging Table
{% docs stg_jaffle_shop__orders %}
This table is the staged version of the source orders table. The column names have been renamed.
{% enddocs %}
## Staged Orders Columns
### order_id
{% docs order_id %}
Key value for an individual order. Each new order should have a new order_id
{% enddocs %}
### customer_id
{% docs customer_id %}
Key value for an individual customer. Each new customer should have a new customer_id.
{% enddocs %}
### order_placed_at
{% docs order_placed_at %}
Time an order was first placed.
{% enddocs %}
### order_status
{% docs order_status %}
The status of an order (renamed from status in source data)
{% enddocs %}
### valid_order_date
{% docs valid_order_date %}
Time valid orders were placed. This means invalid orders return an NULL in this column.
{% enddocs %}
