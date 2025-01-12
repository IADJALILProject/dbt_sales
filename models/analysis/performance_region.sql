WITH performance_regionale AS (
    SELECT
        r.region_name AS region,
        COUNT(s.order_id) AS nombre_commandes,
        SUM(s.total_amount) AS chiffre_affaires,
        ROUND(SUM(s.total_amount) / NULLIF(COUNT(s.order_id), 0), 2) AS panier_moyen
    FROM {{ ref('marts_sales') }} s
    LEFT JOIN {{ ref('marts_regions') }} r ON s.customer_id % 10 = r.region_id -- Exemple de mapping
    GROUP BY r.region_name
)
SELECT
    region,
    nombre_commandes,
    chiffre_affaires,
    panier_moyen
FROM performance_regionale
ORDER BY chiffre_affaires DESC
