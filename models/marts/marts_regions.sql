{{ config(materialized='table') }}

WITH region_sales AS (
    SELECT
        r.region_id,
        r.region_name,
        COUNT(o.order_id) AS total_orders,
        SUM(o.total_amount) AS total_revenue,
        ROUND(SUM(o.total_amount) / NULLIF(COUNT(o.order_id), 0), 2) AS avg_order_value
    FROM {{ ref('stg_regions') }} r
    LEFT JOIN {{ ref('stg_orders') }} o ON r.region_id = o.customer_id % 10 -- Mapping aléatoire pour démo
    GROUP BY r.region_id, r.region_name
)
SELECT
    *
FROM region_sales
