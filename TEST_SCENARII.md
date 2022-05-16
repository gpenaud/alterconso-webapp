# ---------------------------------------------------------------------------- #
#                                     TODO                                     #
# ---------------------------------------------------------------------------- #

# ADMIN - côté commandes

Même chose que côté adhérent, mais pour l'association

# ADMIN - intégrer un nouveau producteur

pour ajouter adiiris
ajouter catalogue
chercher un producteur
créer un producteur

# ADMIN - ajouter des produits

possibilité pour l'administrateur de gérer le catalogue des producteurs

# ADMIN - gestion des catalogues

tous les admins devraient pouvoir gérer totalement les catalogues
A priori, seul les producteurs peuvent gérer leur catalogues désormais

pouvoir créer un producteur
pouvoir créer un catalogue associé au producteur

soit: une fois producteurs créer -> onglet ajouter produit
soit créer un catalogue.

pour les produits, pouvoir modifier:
 - nom
 - prix
 - au kg / litre / à la pièce
 - l'image
 - si AB ou non

dans la fiche du produit, on doit pouvoir classer le produit par type (fruit, produits
laitier)
possibilité d'activer / désactiver le produit
pouvoir créer une commande à la volée dans une distribution spécifique (date précise)
export CSV
Liste d'émargement - GROS BESOIN
Totaux par producteurs - GROS BESOIN

# ADMIN - côté producteur

possiblité de gérer les stocks

# ADMIN - côté distribution

Doit fonctionner
cycle de distribution - distribution régulière
tester création de cycle - est-ce que ça écrase les cycles existants ?

si possible, lors de la création du cycle de distribution, il faudrait:
- mettre 1 seul bénévole
- que tous les producteurs soient associés à la livraison

pouvoir inviter les producteurs
gérer le nb de bénévole
Dans une distribution -> commandes -> modifier commande adhérent

# ADMIN - côté membre

Ajouter membre - il reçoit mail - il se connecte
Sur clic d'un membre
- modifier
- retirer du groupe
- gérer les cotisations

# ADMIN - côté message

Réutiliser un message envoyé
Quand un adhérent répond à cagette, ça arrive sur le mail d'alterconso

# ADMIN - côté paramètres

Possibilités de gérer les droits d'administration
cotisations

# ADHERENT - actions possibles

Commander
S'inscrire en tant que bénévole

# ---------------------------------------------------------------------------- #
#                                      DONE                                    #
# ---------------------------------------------------------------------------- #

# NOTES

## accès admin
admin@cagette.net
admin

## divers

Modification config.xml.dist - modifier config.xml dans dockerfile
chown www-data dans dockerfile lors du copy du conteneur intermédiaire pour fixer erreur std@sys_create_dir
copier le fichier config.xml après installation des packages apache2

# TESTS

Création du compte admin - VALIDE

## gestion des catalogues / producteurs par l'administrateur

créer un catalogue - VALIDE
ajouter adiiris - VALIDE
ajouter un produit - VALIDE
activer / désactiver un produit - VALIDE
NOTE: Impossibilité d'ajouter par défaut des producteur / bénévoles à un cycle de distribution - nécessité de les inscrire chaques semaines

## gestion des distributions

Créer un cycle de distribution - VALIDE
ajouter des catalogues / producteurs à une distribution - VALIDE
tester création de cycle - est-ce que ça écrase les cycles existants ? - NON
Liste d'émargement - VALIDE
Totaux par producteurs

## gestion des membres

envoyer un mail -ERREUR: std@sys_create_dir

## simple utilisateur

passer une simple commande - ERREUR
