{{ config(materialized='table') }}

WITH customer_performance AS (
    SELECT
        c.customer_id,
        c.name AS customer_name,
        c.email,
        COUNT(o.order_id) AS total_orders,
        SUM(o.total_amount) AS total_spent,
        ROUND(SUM(o.total_amount) / NULLIF(COUNT(o.order_id), 0), 2) AS avg_spent_per_order
    FROM {{ ref('stg_customers') }} c
    LEFT JOIN {{ ref('stg_orders') }} o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.name, c.email
)
SELECT
    *
FROM customer_performance
WHERE total_orders IS NOT NULL
  AND total_spent IS NOT NULL