{{ config(materialized='view') }}

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS sales_month,
        COUNT(order_id) AS total_orders,
        SUM(total_amount) AS total_revenue
    FROM {{ ref('marts_sales') }}
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT
    sales_month,
    total_orders,
    total_revenue,
    ROUND(total_revenue::NUMERIC / NULLIF(total_orders, 0), 2) AS avg_order_value
FROM monthly_sales
ORDER BY sales_month
