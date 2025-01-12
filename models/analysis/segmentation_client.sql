{{ config(materialized='view') }}

WITH rfm AS (
    SELECT
        c.customer_id AS client_id,
        MAX(s.order_date) AS derniere_commande,
        COUNT(s.order_id) AS frequence_achats,
        SUM(s.total_amount) AS montant_total,
        EXTRACT(DAY FROM CURRENT_DATE - MAX(s.order_date)) AS recence -- Conversion en jours
    FROM {{ ref('marts_sales') }} s
    LEFT JOIN {{ ref('marts_customers') }} c ON s.customer_id = c.customer_id
    GROUP BY c.customer_id
),
segmentation AS (
    SELECT
        client_id,
        recence,
        frequence_achats,
        montant_total,
        CASE
            WHEN recence <= 30 THEN 'Actif'
            WHEN recence <= 90 THEN 'Inactif Récent'
            ELSE 'Inactif Ancien'
        END AS score_recence,
        CASE
            WHEN frequence_achats > 5 THEN 'Fréquent'
            WHEN frequence_achats BETWEEN 2 AND 5 THEN 'Modéré'
            ELSE 'Rare'
        END AS score_frequence,
        CASE
            WHEN montant_total > 1000 THEN 'Gros Acheteur'
            WHEN montant_total BETWEEN 500 AND 1000 THEN 'Acheteur Moyen'
            ELSE 'Petit Acheteur'
        END AS score_montant
    FROM rfm
)
SELECT
    client_id,
    score_recence,
    score_frequence,
    score_montant,
    score_recence || '-' || score_frequence || '-' || score_montant AS segment_client
FROM segmentation
