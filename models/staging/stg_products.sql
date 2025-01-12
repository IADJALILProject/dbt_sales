{{ config(materialized='table') }}

SELECT
    product_id,
    TRIM(LOWER(name)) AS name, -- Standardisation des noms de produits
    ROUND(price::numeric, 2) AS price -- Normalisation des prix
FROM {{ source('public_raw', 'products') }}

