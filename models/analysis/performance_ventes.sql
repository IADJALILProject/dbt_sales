WITH ventes_par_mois AS (
    SELECT
        DATE_TRUNC('month', order_date) AS mois,
        SUM(total_amount) AS chiffre_affaires_mensuel
    FROM {{ ref('marts_sales') }}
    GROUP BY mois
),
croissance_mensuelle AS (
    SELECT
        mois,
        chiffre_affaires_mensuel,
        LAG(chiffre_affaires_mensuel) OVER (ORDER BY mois) AS ca_mois_precedent,
        ROUND(
            ((chiffre_affaires_mensuel - LAG(chiffre_affaires_mensuel) OVER (ORDER BY mois)) /
             NULLIF(LAG(chiffre_affaires_mensuel) OVER (ORDER BY mois), 0)) * 100, 2
        ) AS taux_croissance
    FROM ventes_par_mois
)
SELECT
    mois,
    chiffre_affaires_mensuel,
    ca_mois_precedent,
    taux_croissance
FROM croissance_mensuelle
ORDER BY mois
