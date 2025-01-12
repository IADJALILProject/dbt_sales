SELECT *
FROM {{ ref('stg_orders') }}
WHERE total_amount < 0 OR total_amount > 10000
