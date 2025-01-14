{% snapshot customer_snapshot %}
{{config (
    target_schema='snapshots',
    unique_key='customer_id',
    strategy='timestamp',  
    updated_at='created_at'  
) }}

WITH customer_performance AS (
    SELECT
        c.customer_id,
        c.name AS customer_name,
        c.email,
        COUNT(o.order_id) AS total_orders,
        SUM(o.total_amount) AS total_spent,
        ROUND(SUM(o.total_amount) / NULLIF(COUNT(o.order_id), 0), 2) AS avg_spent_per_order,
        MAX(c.created_at) AS created_at  -- Important pour incrémental
    FROM {{ ref('stg_customers') }} c
    LEFT JOIN {{ ref('stg_orders') }} o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.name, c.email
)
SELECT
    *
FROM customer_performance
WHERE total_orders IS NOT NULL
  AND total_spent IS NOT NULL
{% endsnapshot %}
