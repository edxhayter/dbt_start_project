with

paid_orders as (

    select * from {{ ref("int__paid_orders") }}

),

-- Final CTE

final as (

    select
        paid_orders.*,
        row_number() over (order by paid_orders.order_id) as transaction_seq,
        row_number()
            over (partition by customer_id order by paid_orders.order_id)
            as customer_sales_seq,

        -- new customer v. returning customer
        case
            -- use a rank and flag first order as new customer
            when (
                rank()
                    over (
                        partition by customer_id
                        order by order_placed_at, order_id
                    )
                = 1
            )
                then 'new'
            else 'return'
        end as nvsr,

        -- customer lifetime value
        sum(total_amount_paid) over (
            partition by paid_orders.customer_id
            order by paid_orders.order_placed_at
        ) as customer_lifetime_value,

        -- first day of sale
        first_value(paid_orders.order_placed_at) over (
            partition by paid_orders.customer_id
            order by paid_orders.order_placed_at
        ) as fdos
    from paid_orders
    order by order_id
)

-- simple select statement
select * from final