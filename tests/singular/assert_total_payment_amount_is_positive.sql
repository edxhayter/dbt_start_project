SELECT 
    total_amount_paid
FROM {{ ref('int__paid_orders') }}
WHERE total_amount_paid < 0