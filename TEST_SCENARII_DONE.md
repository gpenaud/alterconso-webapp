
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
