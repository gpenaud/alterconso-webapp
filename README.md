```

   ______                 __  __                   _       __     __                    
  / ____/___ _____ ____  / /_/ /____              | |     / /__  / /_  ____ _____  ____
 / /   / __ `/ __ `/ _ \/ __/ __/ _ \   ______    | | /| / / _ \/ __ \/ __ `/ __ \/ __ \
/ /___/ /_/ / /_/ /  __/ /_/ /_/  __/  /_____/    | |/ |/ /  __/ /_/ / /_/ / /_/ / /_/ /
\____/\__,_/\__, /\___/\__/\__/\___/              |__/|__/\___/_.___/\__,_/ .___/ .___/
           /____/                                                        /_/   /_/      

```

<p align="center">
  <i>Cagette</i> propose une façon simple pour des producteurs en agriculture biologique de mettre à disposition leurs produits à des consomnateurs locaux. .
</p>

<p align="center">
  <a href="#sommaire">Sommaire</a> •
  <a href="#installation">Installation</a> •
  <a href="#utilisation">Utilisation</a> •
  <a href="#import">Import</a> •
  <a href="#facturation">Facturation</a> •
  <a href="#contribuer">Contribuer</a>

</p>

---

[Cagette 💻](https://github/gpenaud/cagette-webapp) Cagette est une web application, développée en reactJs (frontend) et en haxe (backend), permettant à des groupements d'achats de se constituer. Les producteurs peuvent proposer leurs produits à la vente, et les consomnateurs peuvent auto-organiser des temps de rencontres afin de récupérer leurs commandes.

Cette version de l'application est et restera toujours gratuite et open-source, en accord avec l'entreprise l'ayant conçu. L'objectif de ce repository est de rendre fonctionnelle [la dernière version libre de cagette](https://github.com/CagetteNet/cagette/releases/tag/last_full_haxe_cagette). en effet, il manquait beaucoup de fonctionnalité à cette version, et était inexpoitable telle quelle. De plus, l'installation était difficile et complexe ; grâce à docker, à la réalisation d'une recette ansible, et même d'un package helm, vous avez désormais de multiples façon de déployer cagette sur vos instances ou vos clusters kubernetes.    

Faire tout cela fut un travail long et éprouvant, que j'ai choisi de faire bénévolement. Néanmoins, étant actuellement sans emploi, vous pouvez me soutenir en opérant un don, ou en m'embauchant. Ayez en conscience que le travail effectué vaut environ 15 000€, en me situant dans la fourchette basse du prix en freelance de quelqu'un disposant de mes compétences.

## Installation:

### 1° par conteneur avec docker et docker-compose

#### Pré-requis
* `docker`
* `docker-compose`

#### Déploiement en local

Téléchargez le repository depuis github:
```
git clone https://github.com/gpenaud/cagette-webapp.git
```

Configurez l'application en copiant config.env.sample, puis en remplissant les champs manquants:
```
cp config.env.sample config.env
```

N'oubliez pas, enfin de créer les certificats nécessaires afin de pouvoir activer avec TLS en local.
La target **certificates-install-mkcert** installera l'outil vous permettant de créer ces certificats
ainsi que l'autorité de certification, et surtout de configurer chromium, firefox et tous les autres
navigateurs installés sur votre PC pour qu'ils reconnaissent le-dit certificat.
```
make certificates-install-mkcert
```

La target **certificates-generate**, elle, vous permettra de générer le certificat et sa clef
```
make certificates-generate
```

**NOTE**: Ceci générera le certificat et sa clef dans les dossiers suivants:
* `certificat`: services/apache2/certificates/cert.pem
* `clef`: services/apache2/certificates/key.pem




#### Utilisation de cagette-webapp

Allez dans le répertoire du repository:
```
make up
```

Cette action va déployer 3 conteneurs sur votre poste:
* `cagette-webapp`: l'application cagette
* `cagette-mailer`: le micro-service gérant l'envoi de mails
* `mysql`: la base de données utilisée par cagette-webapp

**Ca y est !** Votre instance locale de cagette est déployée par défaut sur https://cagette.localhost

Pour arrêter cagette-webapp:
```
make down
```

**Note**: Pour déployer cagette avec cette méthode sur un environnement de production, sachez tout d'abord que ça n'est pas secure ; ensuite, l(objectif de ce repository n'est pas de permettre une installation en deux clics pour néophyte, mais de permettre à quelqu'un de technique, ou de non-technique mais très curieux, de déployer facilement son propre cagette. voici les étapes à suivre pour un déploiement sur un serveur avec docker-compose:
* `modification du FQDN dans le vhost`: remplacez toutes les valeurs "cagette.localhost" par votre propre nom de domaine dans services/apache2/vhosts/https.conf. Votre nom de domaine doit être enregitsré sur un registrar DNS et correspondre à une adresse IP. Exemple: cagette.votreassociation.org
* `Mettre votre propre certificat, et sa clef`: vous devez générer votre propre certificat TLS (avec Let's encrypt, par exemple), et les insérer dans services/apache2/certificates/cert.pem et services/apache2/certificates/key.pem.

Grâce à ces deux opérations, en lançant `make up`, docker-compose devrait exposer les ports 80 et 443, et votre serveur devrait répondre à l'adresse https://cagette.votreorganisation.org (l'adresse dépend évidemment du nom de domaine que vous aurez configuré ^^)

### 2° Sur un serveur avec Ansible

Il existe désormais un role ansible pour déployer cagette sur un serveur bare-metal (type ovh dedibox). Vous pouvez trouver la documentation de ce role [sur ce repository github](https://github.com/gpenaud/ansible-role-cagette).

### 3° Sur un cluster Kubernetes

Vous pouvez également déployer cagette sur Kubernetes (k8s ou k3s), grâce à un rôle helm spécialement développé pour ça. La documentation relative au déploiement via helm se trouve sur [le repository consacré à la question](https://github.com/gpenaud/helm-cagette)

### Aide à la mise en place

En cas de difficultés, sachez que je peux tout à fait m'occuper de mettre en ligne votre instance de cagette, mais cela vous coûtera un peu de sous (ou du troc). je ne peux pas me permettre un bénévolat total. Veuillez me contacter pour les tarifs ou les échanges envisageables: guillaume.penaud@gmail.com

## Utilisation

Cagette s'utilise comme n'importe quelle application web ; à votre première utilisation, vous devrez entrer le nom de votre groupe, ainsi que le nom & prénom du référent. Ensuite, vous devrez:

* `créer les catalogues produits`: Ajouter un producteur et définir l'ensemble des produits de son / ses catalogue(s).  
* `créer une distribution, ou un cycle de distributions`: définir quand et ou la distribution des produits s'opérera.  
* `configurer les producteurs de façon à ce qu'ils participent aux distributions`: vous pouvez configurer ça dans l'onglet **catalogues** du site.

Pour toute question relative à l'utilisation et à l'administration du site, je peux également vous accompagner et vous former ; mais comme pour les autres services que je propose, je demanderai une compensation financière pour le temps et l'énergie passée. Contactez moi à l'adresse suivante pour que nous en discutions: **guillaume.penaud@gmail.com**

## Import

La fonctionnalité d'import des produits depuis l'actuel cagette (app.cagette.net) vers votre propre cagette ne fonctionne **pas** depuis l'interface d'administration du site. Les bases de données n'étant pas structurées de la même façon, je n'ai pas pu rendre cette fonctionnalité disponible.

Néanmoins, si vous êtes producteur et que ne souhaitez pas recréer à la main l'ensemble de vos catalogues produits, je peux utiliser une petit programme que j'ai conçu, qui demande un peu de travail de mon côté ; mais qui automatise néanmoins certaines étapes.

## Facturation

### Mise en place d'un serveur cagette
* sur un serveur dédié: **300€**
* sur le cluster kubernetes de l'écolieu du Portail: **250€** (+ frais d'hébergement d'environ **10€** par mois)

### Import des catalogues

* de 1 à 50 produits: **30€**
* à partir de 50 produits: **50€**

## Contribuer

Ce projet a pour objectif de rendre disponible cagette de façon totalement transparente, libre et gratuite, à quiconque dispose des compétences techniques standard de déploiement d'une application web. J'eus aimé avoir les moyens financiers d'aider tout le mondre totalement gratuitement, mais ne touchant ni retraite, ni rente, ni revenu spontanné, je suis forcé de demander une compensation pour les services non-essentiels liés à cette version gratuite de cagette.

Sachez également que si vous souhaitez honorer l'énergie que j'ai mis dans ce projet, vous pouvez procéder à un don, cela m'encouragera à mener d'autres projets bénévoles, et m'aidera à concacrer mon énergie à de l'informatique pour le bien commun.

Mais si les moyens vous manquent, vous pouvez également, à travers un petit mot d'encouragement, contribuer à nourrir mon envie de contribuer au monde à travers des projets éthiques et joyeux.
