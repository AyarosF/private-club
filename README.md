# Le club privé (test rails) - projet THP 6 août 2018

## Après avoir cloné le repo

- `bundle install`

- `rails db:migrate`

## L'application

### Heroku

Vous trouverez l'application hébergée sur Heroku au lien suivant : https://private-club-thp.herokuapp.com/

### Le projet

- La page d'accueil accueille l'utilisateur. Si ce dernier est login, elle lui donnera le lien pour la page du club. S'il n'est pas login, elle lui dira qu'il faut qu'il se login / inscrive pour accéder à la page du club
- Tout au long du site, il y aura une navbar : à gauche, elle redirigera vers la page d'accueil
Si l'utilisateur n'est pas login, la navbar affichera un lien pour se login et un lien pour se register
Si l'utilisateur est connecté, la navbar affichera un lien pour la page du club.
- La page du club affiche toutes les personnes inscrites au site, avec nom, prénom, adresse email
- Tous les utilisateurs connectés peuvent voir les autres pages profils mais seul l'utilisateur connecté peut modifier son profil ou le supprimer

## La team

Ce programme est made in Strasbourg, by Soraya FRUCTUOSO, Samaneh VAEZI et Hugo PAYET avec amour ! Bonne correction les amis :kissing_heart:
