{{ config(materialized='table') }}

WITH enriched_sales AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_date,
        o.total_amount,
        c.name AS customer_name,
        c.email AS customer_email,
        r.region_name
    FROM {{ ref('stg_orders') }} o
    LEFT JOIN {{ ref('stg_customers') }} c ON o.customer_id = c.customer_id
    LEFT JOIN {{ ref('stg_regions') }} r ON r.region_id = o.customer_id % 10 -- Mapping aléatoire pour démo
)
SELECT
    *,
    DATE_TRUNC('month', order_date) AS sales_month
FROM enriched_sales
