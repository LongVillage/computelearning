# Contribuer à computelearning

Tout le contenu du site est constitué de fichiers texte dans `src/content/`,
validés par schéma au build. Les contributions passent par **pull request** ;
la décision de merge revient au mainteneur.

## Ajouter une ressource (la contribution la plus utile)

Créer `src/content/resources/<media>-<nom-court>.yaml` :

```yaml
title: "Titre de la ressource"
medium: minecraft          # id d'un fichier de src/content/media/
concepts:                  # au moins un id de src/content/concepts/
  - portes-logiques
type: video                # video | wiki | article | save | outil | cours | jeu
url: "https://…"
author: "Auteur ou communauté"
lang: en                   # langue de la ressource
license: "CC BY-SA 4.0"    # optionnel, si la ressource est sous licence libre
notes: "Une phrase qui dit pourquoi cette ressource vaut le détour."
duration: 25               # optionnel, durée d'engagement estimée en minutes
```

Puis `npm run build` : une référence cassée ou un champ manquant fait échouer le build.

## Ajouter un média

Tout univers où l'on peut construire une porte logique a sa place. Créer
`src/content/media/<slug>.md` en s'inspirant des existants. Le champ clé est
`primitive` : **qu'est-ce qui joue le rôle de porte logique dans cet univers ?**

## Règles

- Ne lier que des ressources publiquement accessibles, et citer leurs auteurs.
- Ne jamais copier le contenu d'une ressource : on référence, on n'héberge pas
  (exception future : les saves/mondes explicitement partagés pour le site).
- Les cases vides de la matrice (page d'accueil) sont les contributions prioritaires.
- Contenu éditorial en français ; les ressources liées peuvent être dans n'importe
  quelle langue (champ `lang`).
