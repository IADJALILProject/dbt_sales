{{ config(
    materialized='incremental',
    unique_key='customer_id',
    tags=['incremental']
) }}


SELECT
    customer_id,
    TRIM(LOWER(name)) AS name, -- Standardisation des noms
    TRIM(LOWER(email)) AS email, -- Standardisation des emails
    created_at::timestamp AS created_at -- Conversion explicite en timestamp
FROM {{ source('public_raw', 'customers') }}
{% if is_incremental() %}
    WHERE created_at > (SELECT MAX(created_at) FROM {{ this }}) -- Incrémentiel : uniquement les nouvelles données
{% endif %}
