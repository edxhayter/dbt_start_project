WITH orders as (
    SELECT * FROM {{ref('stg_jaffle_shop__orders')}}
),
payments as (
    select * FROM {{ref('stg_stripe__payments')}}
),

order_payments as (
    SELECT
        order_id,
        sum(case when payment_status = 'success' then amount_$ end) as amount
    FROM payments
    group by 1
),

final as (
    SELECT
        orders.order_id,
        orders.customer_id,
        orders.valid_order_date,
        coalesce (order_payments.amount, 0) as amount
    FROM orders
    LEFT JOIN order_payments on orders.order_id=order_payments.order_id
)

SELECT * FROM FINAL