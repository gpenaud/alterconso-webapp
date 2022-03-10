# Déploiement simplifié de cagette

Merci de contacter Guillaume Penaud (guillaume.penaud@gmail.com) pour toute question.

Ce repository héberge le code nécessaire pour déployer cagette. Deux méthodes sont possibles et recommandées:

### Via un conteneur docker
Une version conteneurisée de cagette, via une stack locale docker-compose. voici les requirements:

- docker
- docker-compose

Les quelques commandes à connaître sont très simples:

Pour monter l'environnement (le site est joignable sur http://localhost:80)
```
 docker-compose up --build -d
```


Pour stopper l'environnement
```
 docker-compose down
```

### Sur un serveur on-premise, type VPS de chez OVH

Le fichier Makefile contient toutes les actions possibles pour générer un serveur ; le script terraform utilise ensuite ansible pour configurer et déployer cagette sur le serveur.

Cette partie est toujours en cours, et en attente de test de l'applicatif sous sa forme de conteneur.  
