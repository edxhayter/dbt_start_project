SELECT
    customer_id,
    count('customer_id') AS count_id
FROM {{ ref('dim_customers') }}
GROUP BY 1
HAVING count_id > 1
