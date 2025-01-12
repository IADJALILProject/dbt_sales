# Règles Métiers

## 1. Assignation des Régions
- Les régions sont définies en fonction des `region_id` dans `stg_regions`.
- Exemple de mapping :
  - `1` : Amérique du Nord.
  - `2` : Europe.

## 2. Validation des Commandes
- Les commandes avec un montant `total_amount` négatif sont considérées comme invalides.
- Ces données sont exclues des analyses dans `marts_sales`.

## 3. Classification des Clients
- Les clients sont classés en segments RFM (Récence, Fréquence, Montant) selon :
  - **Récence** : Temps depuis la dernière commande.
  - **Fréquence** : Nombre de commandes passées.
  - **Montant** : Total dépensé.
