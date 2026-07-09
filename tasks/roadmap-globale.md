# Roadmap — computelearning

Cap : **finir la v1** — le catalogue de liens qui prouve le concept. Tout le reste
est parqué dans [docs/idees.md](../docs/idees.md) et n'entre ici que converti en
tranche. Format tranches : voir le skill roadmap. Jamais de dates.

## État constaté (2026-07-09)

Le socle v1 est livré : site statique Astro, 3 collections validées par schéma,
matrice concepts × médias en home, pages par média et par concept, 8 concepts,
6 médias, 13 ressources aux liens vérifiés, repo public `main` protégée.
Build vert (`npm run build`, 18 pages).

## Tranches v1

### T-ci-build-pr — CI de build sur les PR  ✅

- **Objectif** : toute PR (interne ou externe) est validée par un build automatique ;
  une ressource au format cassé produit un check rouge visible avant merge.
- **Dépend de** : —
- **Fichiers** : `.github/workflows/**`
- **DoD** : workflow vert sur `main` ; une PR de test avec une référence cassée
  (`medium: inexistant`) affiche un check rouge, puis est fermée sans merge.
- **Flottaison** : le job deploy (2026-07-09) ne tourne jamais sur PR — les secrets
  restent inaccessibles aux forks.
- *Preuve (2026-07-09) : job `build` de `.github/workflows/site.yml`, tourne sur
  PR et push ; le build valide schémas zod + références. Reste à démontrer le
  check rouge sur une PR de test réelle à la première occasion.*

### T-deploy-scaleway — Site en prod sur Scaleway  ✅

- **Objectif** : le site est servi en HTTPS public depuis Scaleway, redéployé à
  chaque push sur `main`, pour ~1 €/mois.
- **Dépend de** : —
- **Fichiers** : `infra/**`, `.github/workflows/**`
- **DoD** : `terraform plan` sans changement ; `curl -I` → 200 sur l'URL Edge ;
  push → Action verte → changement en ligne.
- *Preuve (2026-07-09) : `No changes. Your infrastructure matches the
  configuration.` ; HTTP/2 200 sur
  https://2d7b7ca2-9ded-41d4-b573-d7552f027199.svc.edge.scw.cloud (home,
  sous-pages, 404) ; 12 ressources Terraform, state distant privé.*

### T-densifier-catalogue — 4 médias et ~10 ressources de plus  ⬜

- **Objectif** : la matrice passe à ~10 colonnes ; les nouveaux médias prioritaires
  (électronique réelle/Ben Eater, NandGame, nand2tetris, Logic World) existent avec
  leurs ressources, et les trous les plus visibles des colonnes actuelles sont comblés.
- **Dépend de** : —
- **Fichiers** : `src/content/media/**`, `src/content/resources/**`
- **DoD** : `npm run build` vert ; chaque nouvelle URL répond (HEAD 200 ou
  oEmbed pour YouTube) ; ≥ 45 cases pleines dans la matrice (33 aujourd'hui).
- **Flottaison** : pas de nouveau concept (l'échelle à 8 barreaux ne bouge pas en v1) ;
  pas d'hébergement de saves.

### T-identite-minimale — Favicon, métadonnées sociales, page à propos  ⬜

- **Objectif** : le site est partageable proprement — favicon à nous (plus celui
  d'Astro), balises OpenGraph/description, courte page « à propos » qui porte le
  pitch et pointe vers GitHub.
- **Dépend de** : —
- **Fichiers** : `public/**`, `src/layouts/**`, `src/pages/a-propos.astro`
- **DoD** : `npm run build` vert ; un partage de lien (vérifié via les balises OG
  du HTML généré) affiche titre + description corrects ; favicon visible.
- **Flottaison** : pas de refonte graphique, pas de logo travaillé.

## Fin de v1

V1 est déclarée finie quand les trois tranches ci-dessus sont ✅. Le chantier
suivant probable est l'hébergement Scaleway (idée n°7) — décision à prendre à ce
moment-là, pas avant.

## Parqué

Tout le reste — mondes hébergés, types de médias non-jeux, accompagnement IA,
recherche, simulations interactives, Scaleway, version anglaise, vision
méta-apprentissage — vit dans [docs/idees.md](../docs/idees.md).
