-- import models
with 

customers as (

    select * from {{ ref("stg_jaffle_shop__customers") }}

),

orders as (

    select * from {{ ref("stg_jaffle_shop__orders") }}

),

payments as (

    select * from {{ ref('stg_stripe__payments') }}

),

-- logical CTEs
order_amounts as (

    select
        order_id,
        max(payment_created_at) as payment_finalized_date,
        sum(amount_$) as total_amount_paid
    from payments

    --might need to update this field name
    where payment_status <> 'fail'
    group by 1

),

paid_orders as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_placed_at,
        orders.order_status,

        order_amounts.total_amount_paid,
        order_amounts.payment_finalized_date,

        customers.customer_first_name,
        customers.customer_last_name
    from orders
    left join order_amounts
        on orders.order_id = order_amounts.order_id
    left join customers
        on orders.customer_id = customers.customer_id
)

select * from paid_orders