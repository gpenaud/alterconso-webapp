# Déploiement simplifié de cagette

Merci de contacter Guillaume Penaud (guillaume.penaud@gmail.com) pour toute question.

Ce repository héberge le code d'infrastructure nécessaire pour déployer l'application cagette.
Deux méthodes sont possibles et recommandées:

### Via un conteneur docker

Une version conteneurisée de cagette, via une stack locale docker-compose.
Vous aurez besoin des packages suivants:

- docker >= 20.10.7
- docker-compose >= 1.25.1-rc1

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

## Utiliser cagette

Une fois installé, vous devez d'abord initialiser cagette:

```
http://IP_DU_SERVEUR:80/install
```

Et enfin, cagette est prêt à être utilisé

```
http://IP_DU_SERVEUR:80
```
