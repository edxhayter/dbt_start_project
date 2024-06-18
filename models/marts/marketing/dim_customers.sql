with 

customers as (
    select *
    from {{ref('stg_jaffle_shop__customers') }}

),

orders as (
    select * 
    from {{ref('fct_orders') }}

),

customer_orders as (
    select
        customer_id,

        min(valid_order_date) as first_order,
        max(valid_order_date) as most_recent_order,
        count(order_id) as number_of_orders,
        sum(amount) as lifetime_value
    from orders

    group by customer_id
),

final as (

    select
        customers.customer_id,
        customers.customer_first_name,
        customers.customer_last_name,
        customer_orders.first_order,
        customer_orders.most_recent_order,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        customer_orders.lifetime_value
    from customers

    left join customer_orders
        on customers.customer_id = customer_orders.customer_id
)

select * from final


--default behavior is to materialize as a view, config at top changes to table

-- dbt run --select dim_customers
-- ^^ in command line will only run selective model