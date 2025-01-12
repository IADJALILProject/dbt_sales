{{ config(materialized='table') }}

SELECT
    region_id,
    INITCAP(region_name) AS region_name -- Capitalisation correcte des noms de région
FROM {{ source('public_raw', 'regions') }}
