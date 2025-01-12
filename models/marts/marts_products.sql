{{ config(materialized='table') }}

WITH product_performance AS (
    SELECT
        p.product_id,
        p.name AS product_name,
        COUNT(o.order_id) AS total_orders,
        SUM(o.total_amount) AS total_revenue,
        ROUND(SUM(o.total_amount) / NULLIF(COUNT(o.order_id), 0), 2) AS avg_order_value
    FROM {{ ref('stg_products') }} p
    LEFT JOIN {{ ref('stg_orders') }} o ON o.order_id = p.product_id % 50 -- Mapping aléatoire pour démo
    GROUP BY p.product_id, p.name
)
SELECT
    *
FROM product_performance
WHERE total_orders IS NOT NULL
  AND total_revenue IS NOT NULL
