# Déploiement de cagette

## qu'est-ce que cagette ?

Cagette est une web application, développée en reactJs (frontend) et en haxe (backend),
permettant à des groupements d'achats de se constituer. Les producteurs peuvent proposer
leurs produits à la vente, et les consomnateurs peuvent auto-organiser des temps de
rencontres afin de récupérer leurs commandes.  

## Qui a développé cagette ?

Les développeurs de Cagette sont une entreprise bordelaise nommée __NAME__
Ce repository est le fruit d'un travail de Guillaume Penaud, afin de rendre disponible
et aisément installable une version totalement gratuite (mais relativement obsolète
au regard de celle vendue par __NAME__) de cagette.

Vous pouvez joindre Guillaume à l'adresse suivante: guillaume.penaud@gmail.com.

## Comment déployer (installer) cagette ?

Vous pouvez déployer cagette de 3 façons, en fonction de votre environnement.
La plus simple est un déploiement sous la forme d'un conteneur docker.

- soit en conteneur "simple" (via docker-compose)
- soit dans le cadre de l'orchestrateur de conteneur kubernetes

Il existe enfin un role ansible que vous pouvez utiliser pour déployer cagette
en mode non-conteneur sur un serveur de type dédié.

NOTE: Ce rôle ansible n'est actuellement certifié que sur ubuntu version 20.04

### La méthode conteneur "simple"



### La méthode conteneur "kubernetes"



### La méthode non-conteneur via ansible




### Via un conteneur docker

Une version conteneurisée de cagette, via une stack locale docker-compose.
Vous aurez besoin des packages suivants:

- docker >= 20.10.7
- docker-compose >= 1.25.1-rc1

1° Setup l'environnement

Dans un fichier environment.txt:
```
export CAGETTE_SMTP_USER="Ecolieu Le Portail"
export CAGETTE_SMTP_PASSWORD=""
export CAGETTE_SQL_LOG=0
export CAGETTE_DEBUG=1
```

2° Monter l'environnement (le site est joignable sur http://localhost:80)
```
make up
```

3° Stopper l'environnement
```
make down
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

# modules

5612701 4.0K drwxr-xr-x 1 root root 4.0K May 13 05:36 .
5619732 4.0K drwxr-xr-x 1 root root 4.0K May 13 05:36 ..
4200031    0 lrwxrwxrwx 1 root root   36 May  9 07:48 access_compat.load -> ../mods-available/access_compat.load
4200032    0 lrwxrwxrwx 1 root root   28 May  9 07:48 alias.conf -> ../mods-available/alias.conf
4200033    0 lrwxrwxrwx 1 root root   28 May  9 07:48 alias.load -> ../mods-available/alias.load
4200034    0 lrwxrwxrwx 1 root root   33 May  9 07:48 auth_basic.load -> ../mods-available/auth_basic.load
4200035    0 lrwxrwxrwx 1 root root   33 May  9 07:48 authn_core.load -> ../mods-available/authn_core.load
4200036    0 lrwxrwxrwx 1 root root   33 May  9 07:48 authn_file.load -> ../mods-available/authn_file.load
4200037    0 lrwxrwxrwx 1 root root   33 May  9 07:48 authz_core.load -> ../mods-available/authz_core.load
4200038    0 lrwxrwxrwx 1 root root   33 May  9 07:48 authz_host.load -> ../mods-available/authz_host.load
4200039    0 lrwxrwxrwx 1 root root   33 May  9 07:48 authz_user.load -> ../mods-available/authz_user.load
4200040    0 lrwxrwxrwx 1 root root   32 May  9 07:48 autoindex.conf -> ../mods-available/autoindex.conf
4200041    0 lrwxrwxrwx 1 root root   32 May  9 07:48 autoindex.load -> ../mods-available/autoindex.load
4200042    0 lrwxrwxrwx 1 root root   30 May  9 07:48 deflate.conf -> ../mods-available/deflate.conf
4200043    0 lrwxrwxrwx 1 root root   30 May  9 07:48 deflate.load -> ../mods-available/deflate.load
4200044    0 lrwxrwxrwx 1 root root   26 May  9 07:48 dir.conf -> ../mods-available/dir.conf
4200045    0 lrwxrwxrwx 1 root root   26 May  9 07:48 dir.load -> ../mods-available/dir.load
4200046    0 lrwxrwxrwx 1 root root   26 May  9 07:48 env.load -> ../mods-available/env.load
4200047    0 lrwxrwxrwx 1 root root   29 May  9 07:48 filter.load -> ../mods-available/filter.load
4200048    0 lrwxrwxrwx 1 root root   27 May  9 07:48 mime.conf -> ../mods-available/mime.conf
4200049    0 lrwxrwxrwx 1 root root   27 May  9 07:48 mime.load -> ../mods-available/mime.load
5557905    0 lrwxrwxrwx 1 root root   33 May 13 05:36 mpm_worker.conf -> ../mods-available/mpm_worker.conf
5557912    0 lrwxrwxrwx 1 root root   33 May 13 05:36 mpm_worker.load -> ../mods-available/mpm_worker.load
4200052    0 lrwxrwxrwx 1 root root   34 May  9 07:48 negotiation.conf -> ../mods-available/negotiation.conf
4200053    0 lrwxrwxrwx 1 root root   34 May  9 07:48 negotiation.load -> ../mods-available/negotiation.load
4200054    0 lrwxrwxrwx 1 root root   27 May  9 07:48 neko.conf -> ../mods-available/neko.conf
4200055    0 lrwxrwxrwx 1 root root   27 May  9 07:48 neko.load -> ../mods-available/neko.load
4200056    0 lrwxrwxrwx 1 root root   33 May  9 07:48 reqtimeout.conf -> ../mods-available/reqtimeout.conf
4200057    0 lrwxrwxrwx 1 root root   33 May  9 07:48 reqtimeout.load -> ../mods-available/reqtimeout.load
5557915    0 lrwxrwxrwx 1 root root   30 May 13 05:36 rewrite.load -> ../mods-available/rewrite.load
4200058    0 lrwxrwxrwx 1 root root   31 May  9 07:48 setenvif.conf -> ../mods-available/setenvif.conf
4200059    0 lrwxrwxrwx 1 root root   31 May  9 07:48 setenvif.load -> ../mods-available/setenvif.load
5557917    0 lrwxrwxrwx 1 root root   36 May 13 05:36 socache_shmcb.load -> ../mods-available/socache_shmcb.load
5557920    0 lrwxrwxrwx 1 root root   26 May 13 05:36 ssl.conf -> ../mods-available/ssl.conf
5557928    0 lrwxrwxrwx 1 root root   26 May 13 05:36 ssl.load -> ../mods-available/ssl.load
4200060    0 lrwxrwxrwx 1 root root   29 May  9 07:48 status.conf -> ../mods-available/status.conf
4200061    0 lrwxrwxrwx 1 root root   29 May  9 07:48 status.load -> ../mods-available/status.load
