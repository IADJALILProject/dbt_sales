{{ config(materialized='table') }}

SELECT
    order_id,
    customer_id,
    order_date::timestamp,
    ROUND(total_amount::numeric, 2) AS total_amount -- Standardisation des montants
FROM {{ source('public_raw', 'orders') }}

