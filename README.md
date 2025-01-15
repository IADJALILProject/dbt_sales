

---

```markdown
# dbt_sales

**dbt_sales** est un projet de modélisation de données avec **dbt (Data Build Tool)**,
 conçu pour transformer des données brutes en insights analytiques prêts à être visualisés et exploités.

---

## 🛠️ Fonctionnalités principales

### 🔹 Modélisation des données
- Nettoyage et transformation des données avec des tables de staging.
- Création de modèles analytiques pour les insights commerciaux et opérationnels.
- Analyses avancées comme la segmentation client et les performances régionales.

### 🔹 Orchestration automatisée
- Orchestration complète via **Prefect**.
- Suivi des exécutions dans le tableau de bord **Prefect Orion**.

### 🔹 Tests de qualité des données
- Tests préconfigurés pour valider l'intégrité des données (unicité, relations, non-nullité).

---

## 📂 Structure du projet

```
dbt_sales/
├── models/
│   ├── marts/             # Modèles analytiques pour les KPI
│   ├── staging/           # Tables intermédiaires pour les données brutes
│   └── analysis/          # Modèles d'analyse (KPI, segmentation, etc.)
├── seeds/                 # Fichiers CSV pour initialiser les données brutes
├── macros/                # Fonctions réutilisables pour dbt
├── tests/                 # Tests de validation personnalisés
├── orchestrate_dbt_with_prefect.py  # Script pour l'orchestration avec Prefect
├── dbt_project.yml        # Fichier de configuration dbt
└── README.md              # Documentation du projet
```

---

Ah, je vois ! Tu veux parler de l'utilisation de macros comme **fonctions utilitaires indépendantes** (et non intégrées directement dans des modèles). Voici une version modifiée et plus précise :

---

## 🚀 Étapes pour exécuter le projet

### 1️⃣ Configuration de dbt
- Assurez-vous que votre fichier `profiles.yml` est correctement configuré pour se connecter à votre base de données.
- Configurez les **snapshots** pour capturer l'état des données (via un fichier dédié comme `snapshot_config.yml`).

### 2️⃣ Initialiser le projet
Validez la configuration de votre environnement dbt :

```bash
dbt debug
```

### 3️⃣ Charger les données brutes
Chargez les données initiales définies dans vos fichiers de seed :

```bash
dbt seed
```

### 4️⃣ Exécuter les modèles
Lancez toutes les transformations :

```bash
dbt run
```

Pour exécuter uniquement les modèles incrémentaux :

```bash
dbt run --selector incremental
```

### 5️⃣ Valider les données
Lancez vos tests pour vérifier l'intégrité et la qualité des données :

```bash
dbt test
```

### 6️⃣ Utilisation des snapshots
Pour capturer les états des données :

```bash
dbt snapshot
```

### 7️⃣ Générer la documentation
Créez et servez une documentation interactive :

```bash
dbt docs generate
dbt docs serve
```

### 8️⃣ Utilisation des tags
Pour exécuter uniquement les modèles liés à un **tag spécifique** (par exemple, `customers`) :

```bash
dbt run --select tag:customers
```

🌟 Utilisation de macros pour des calculs seuls

Les macros permettent d'automatiser des calculs ou des transformations répétitives dans vos modèles dbt. Voici deux exemples courants de macros et comment les utiliser efficacement.
Exemple 1 : Macro calculate_rate
Définition

La macro calculate_rate calcule un pourcentage basé sur un numérateur et un dénominateur, avec une gestion des cas où le dénominateur est égal à zéro.

{% macro calculate_rate(numerator, denominator) %}
    CASE
        WHEN {{ denominator }} = 0 THEN 0
        ELSE ROUND(({{ numerator }} * 100.0 / {{ denominator }}), 2)
    END
{% endmacro %}

Utilisation

Appelons cette macro dans un modèle dbt pour calculer un taux de conversion :

SELECT
    user_id,
    {{ calculate_rate('completed_orders', 'total_orders') }} AS conversion_rate
FROM {{ ref('orders') }}

Exemple 2 : Macro calculate_revenue_metrics
Définition

La macro calculate_revenue_metrics calcule le revenu moyen par une unité donnée, avec une gestion des divisions par zéro.

{% macro calculate_revenue_metrics(total_revenue, count_value) %}
    CASE
        WHEN {{ count_value }} = 0 THEN 0
        ELSE ROUND({{ total_revenue }} / {{ count_value }}, 2)
    END
{% endmacro %}

Utilisation

Appelons cette macro dans un modèle pour calculer le revenu moyen par utilisateur :

SELECT
    user_id,
    {{ calculate_revenue_metrics('total_revenue', 'active_days') }} AS avg_revenue_per_day
FROM {{ ref('user_metrics') }}

🛠️ Exécution des macros seules

Ces macros sont principalement conçues pour être utilisées dans des modèles. Cependant, vous pouvez également les tester ou les exécuter indépendamment via la commande suivante :

dbt run-operation print_message --args '{"message": "Test de macro"}'

Pour tester une macro en ligne de commande, vous pouvez écrire une macro comme celle-ci :

{% macro test_calculate_rate() %}
    {% set result = calculate_rate(50, 100) %}
    {{ log(result, info=True) }}
{% endmacro %}

Puis exécutez-la :

dbt run-operation test_calculate_rate

## 📊 Analyses et KPI disponibles

### 🔹 Segmentation client
- Classification des clients en fonction de leur récence, fréquence, et montant des achats.
- Résultat : `Actif`, `Inactif récent`, `Inactif ancien`.

### 🔹 Performances des ventes
- Analyse des revenus par produit, région, et client.
- Résultat : Revenu total, commandes moyennes, et valeur moyenne des commandes.

### 🔹 Revenus régionaux
- Revenus totaux et moyens par région, ainsi que nombre de clients par région.

---

## 🧪 Tests dbt

Le projet inclut des tests de validation pour garantir la qualité des données :
- **Tests automatiques** :
  - Unicité des colonnes clés (`unique`).
  - Relations clés étrangères (`relationships`).
  - Non-nullité des données (`not_null`).
- **Tests personnalisés** :
  - Valeurs acceptées pour les métriques importantes (montants, commandes, etc.).

---

## ⚙️ Orchestration avec Prefect

Le script **`orchestrate_dbt_with_prefect.py`** gère toutes les étapes automatiquement :
1. Vérification de la configuration.
2. Chargement des fichiers seed.
3. Exécution des modèles et analyses.
4. Tests de validation.
5. Génération de documentation.

Suivez l'exécution dans le tableau de bord Prefect Orion : [http://127.0.0.1:4200](http://127.0.0.1:4200).

---

## 📋 Pré-requis

- **Python 3.10+**
- **dbt-core 1.x**
- **Prefect 2.x**
- Base de données compatible (ex. : PostgreSQL, Snowflake).

---

## 📝 À propos

Ce projet a été développé pour fournir une solution complète de modélisation, analyse, et orchestration des données. Si vous avez des suggestions ou des questions, n'hésitez pas à ouvrir une issue ou une pull request.

---

## 📧 Contact

Pour toute question, contactez-moi à :
- **Email** : salahbeydjalil@gmail.com

---

## 🏆 Contributions

Les contributions sont les bienvenues ! Merci de suivre ces étapes :
1. Forkez le projet.
2. Créez une branche pour vos modifications (`git checkout -b feature-nom`).
3. Effectuez vos commits (`git commit -m "Ajout de XYZ"`).
4. Poussez vos modifications (`git push origin feature-nom`).
5. Ouvrez une pull request.

---

**🎉 Merci de votre intérêt pour dbt_sales et bonne exploration !** 🚀
```

---

### **Étapes pour intégrer ce README**
1. Enregistrez ce contenu dans un fichier `README.md` à la racine de votre projet.
2. Effectuez un commit :
   ```bash
   git add README.md
   git commit -m "Ajout d'un README structuré"
   git push origin main
   ```

Si vous avez besoin de modifications supplémentaires ou de sections spécifiques, n’hésitez pas à demander ! 😊`
