# ToysAndModels
Le projet consiste à développer un tableau de bord interactif dans Power BI pour suivre la performance de l'entreprise dans les domaines des ventes, finances, logistique et ressources humaines.

# Description Détailée du Projet
# 1. Contexte et Objectifs
   
L'entreprise en question vend des maquettes et des modèles réduits. Elle possède déjà une base de données complète répertoriant plusieurs informations essentielles pour son fonctionnement, comme les employés, les produits, les commandes, etc. Le directeur souhaite disposer d’un tableau de bord afin de suivre facilement l’activité de l’entreprise. Ce tableau de bord devra être actualisé chaque matin pour fournir des informations à jour et pertinentes sur les aspects suivants :

Ventes : Le directeur doit pouvoir suivre le nombre de produits vendus chaque mois, par catégorie. Il est important d'inclure une comparaison avec les chiffres du mois précédent et du même mois de l'année précédente pour analyser la performance et détecter d'éventuelles tendances.

Finances : Le tableau de bord devra afficher le chiffre d’affaires des commandes pour les deux derniers mois, réparti par pays. Il devra également permettre de suivre les commandes qui n'ont pas encore été payées, afin que le directeur puisse prendre les mesures nécessaires.

Logistique : L'entreprise souhaite avoir une visibilité sur les produits les plus populaires en termes de commandes. Ainsi, le stock des 5 produits les plus commandés devra être affiché dans le tableau de bord.

Ressources Humaines : Le directeur souhaite savoir chaque mois quels sont les deux vendeurs ayant réalisé le plus grand chiffre d'affaires, afin de suivre la performance de ses équipes commerciales.

# 2. Données à Utiliser
Le projet nécessite de travailler avec plusieurs tables de données présentes dans la base de données de l'entreprise :

Table des produits : Cette table contient les informations relatives aux produits, telles que les catégories, les quantités en stock et les prix.
Table des commandes : Elle répertorie les informations sur chaque commande, y compris la quantité achetée, le montant de la commande, et la date d’achat.
Table des employés : Cette table contient des informations sur les employés, dont les vendeurs, et leurs performances.
Table des paiements : Elle répertorie les paiements effectués, et permet d'identifier les commandes qui n’ont pas encore été payées.
3. Les KPIs à Développer
Le projet implique la création de plusieurs KPIs essentiels à la gestion de l’entreprise. Voici une liste de ces KPIs :

Ventes :
Nombre de produits vendus par catégorie et par mois.
Taux de variation des ventes par rapport au même mois de l'année précédente.
Finances :
Chiffre d'affaires des commandes des deux derniers mois, par pays.
Nombre de commandes non payées.
Logistique :
Suivi des stocks des 5 produits les plus commandés.
Ressources humaines :
Identification des 2 meilleurs vendeurs chaque mois, selon leur chiffre d'affaires.

# 4. Modélisation des Données
Avant de passer à la création des visualisations dans Power BI, il sera essentiel de modéliser correctement les données. Cela implique de :

Explorer la structure de la base de données pour comprendre comment les différentes tables sont reliées entre elles.
Créer des relations entre les tables Produits, Commandes, Employés, et Paiements pour garantir une analyse fluide et cohérente.
Ensuite, il faudra créer des mesures DAX pour calculer les différents KPIs. Par exemple, pour les ventes mensuelles, il faudra sommer les quantités de produits vendus pour chaque mois, tandis que pour les commandes non payées, il faudra identifier celles dont le statut de paiement est en attente.

# 5. Création des Visualisations
Une fois les données prêtes, l'étape suivante est la création des visualisations dans Power BI. Chaque thème sera représenté par des visualisations spécifiques :

Ventes : Graphiques en barres ou en courbes pour afficher les ventes par catégorie et par mois. Un graphique de comparaison avec l'année précédente permettra de suivre l'évolution.

Finances : Des cartes ou graphiques en colonnes pour le chiffre d'affaires par pays et une table pour les commandes non payées.

Logistique : Un graphique en barres ou un tableau pour afficher les 5 produits les plus vendus et leur stock restant.

Ressources Humaines : Un graphique pour identifier les 2 meilleurs vendeurs du mois en termes de chiffre d'affaires.

# 6. Interactivité et Actualisation des Données

Pour rendre le tableau de bord plus interactif et utile, des filtres (slicers) seront ajoutés, permettant de filtrer les données par pays, période, ou même catégorie de produits.

L’actualisation automatique des données sera également configurée pour que le tableau de bord soit mis à jour chaque matin avec les dernières informations disponibles.

# 7. Déploiement et Partage

Une fois que le tableau de bord est terminé, il sera publié sur Power BI Service pour permettre au directeur et aux autres utilisateurs d'y accéder. Le partage des résultats et la possibilité d'exporter les données ou de recevoir des alertes par email sont également essentiels pour garantir que les informations sont suivies de manière proactive.

# Conclusion
Le projet vise à créer un tableau de bord complet et interactif dans Power BI pour permettre au directeur de suivre de manière dynamique et efficace les performances de l'entreprise dans les domaines de Ventes, Finances, Logistique, et Ressources Humaines. Ce tableau de bord sera une aide précieuse pour la gestion quotidienne de l'entreprise, offrant des informations actualisées et des KPIs clairs pour prendre des décisions éclairées.
