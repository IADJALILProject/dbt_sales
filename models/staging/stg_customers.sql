{{ config(materialized='table') }}

SELECT
    customer_id,
    TRIM(LOWER(name)) AS name, -- Standardisation des noms
    TRIM(LOWER(email)) AS email, -- Standardisation des emails
    created_at::timestamp
FROM {{ source('public_raw', 'customers') }}
