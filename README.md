`Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
"# dbt_sales" 
`📊 Analyses et KPI
Modèles analytiques :
Segmentation client :
Récence, fréquence, et montant des achats.
Classification en segments : Actif, Inactif récent, etc.
Performance des ventes :
Revenu par produit, région, et client.
Revenu par région :
Analyse des revenus par région et client.
Tableaux disponibles :
marts_sales : Détail des ventes (commandes, clients, produits, régions).
marts_customers : Analyse des dépenses clients.
marts_regions : Performance régionale.
🧪 Tests dbt
Le projet inclut des tests pour garantir la qualité des données :

Tests de colonnes :
Non nullité (not_null).
Unicité (unique).
Relations (relationships).
Tests personnalisés :
Vérification des limites de valeurs (ex. montant positif).
Correspondance des clés étrangères.
⚙️ Orchestration Prefect
Le script orchestrate_dbt_with_prefect.py exécute toutes les étapes automatiquement :

Vérification (debug).
Chargement des seeds.
Exécution des modèles et analyses.
Tests de qualité.
Génération de documentation.
Suivez l'exécution via le tableau de bord Prefect Orion.

📋 Pré-requis
Python 3.10+
dbt-core 1.x
Prefect 2.x
Base de données (PostgreSQL, Snowflake, etc.).
📝 À propos
Ce projet a été conçu pour transformer des données brutes en insights exploitables grâce à dbt. Si vous avez des suggestions ou des questions, n'hésitez pas à ouvrir une issue ou à proposer une pull request.

