# Définitions des KPI

## 1. Chiffre d'Affaires (CA)
- **Description** : Somme totale des revenus générés par les commandes.
- **Calcul** :
  \[
  \text{CA} = \sum(\text{total_amount})
  \]
- **Source de Données** : `marts_sales`.

## 2. Panier Moyen
- **Description** : Montant moyen dépensé par commande.
- **Calcul** :
  \[
  \text{Panier Moyen} = \frac{\text{CA Total}}{\text{Nombre de Commandes}}
  \]
- **Source de Données** : `marts_sales`.

## 3. Taux de Rétention
- **Description** : Pourcentage de clients ayant passé plusieurs commandes.
- **Calcul** :
  \[
  \text{Taux de Rétention} = \frac{\text{Clients Actifs}}{\text{Clients Totaux}} \times 100
  \]
- **Source de Données** : `marts_customers`.
