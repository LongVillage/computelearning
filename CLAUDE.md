# computelearning

Catalogue libre des représentations d'un ordinateur à travers différents médias
(Minecraft, Factorio, jeu de la vie…), organisé en **matrice concepts × médias**.
Site statique Astro, contenu = fichiers versionnés dans `src/content/`.

## Le modèle de données (la colonne vertébrale du projet)

Trois collections, définies dans `src/content.config.ts` :

- `src/content/concepts/*.md` — l'échelle pédagogique du bit au programme,
  ordonnée par `order`. On n'ajoute pas un concept à la légère : c'est la
  structure de tout le site.
- `src/content/media/*.md` — un univers où construire un ordinateur. Champ clé :
  `primitive` (ce qui y joue le rôle de porte logique).
- `src/content/resources/*.yaml` — une ressource externe reliant un média à ≥1
  concepts. C'est là que le catalogue grandit. Nommage : `<media>-<nom-court>.yaml`.

Règles de contenu :
- Contenu éditorial en **français** ; les ressources liées peuvent être en anglais.
- Toujours vérifier qu'une URL répond avant de l'ajouter (les vidéos YouTube :
  vérifier titre/auteur via `https://www.youtube.com/oembed?url=…`).
- On référence, on ne copie pas : citer les auteurs, respecter les licences.
- `npm run build` valide tout le contenu (schémas zod + références) — le lancer
  avant de considérer un ajout terminé.

## Développement

Dev server en arrière-plan : `astro dev --background` (puis `astro dev stop`,
`astro dev status`, `astro dev logs`).

Docs Astro : https://docs.astro.build — notamment
[content collections](https://docs.astro.build/en/guides/content-collections/) et
[routing](https://docs.astro.build/en/guides/routing/).

## Gouvernance & déploiement

- Repo public, `main` protégée : tout passe par PR, merge = décision de Julien.
- **Prod : https://www.onverraplustard.eu** (URL canonique ; le endpoint
  https://2d7b7ca2-9ded-41d4-b573-d7552f027199.svc.edge.scw.cloud reste actif).
  Bucket Scaleway + Edge Services, voir `infra/README.md`. L'apex nu ne sert pas
  de HTTPS (limitation CNAME d'Edge Services, expliquée dans `infra/main.tf`).
  Déploiement
  automatique à chaque push sur `main` (`.github/workflows/site.yml`) ;
  cache Edge TTL 1 h, pas de purge auto.
- Infra : Terraform dans `infra/`, apply manuel en local uniquement
  (`AWS_PROFILE=scaleway` + `TF_VAR_project_id` + `TF_VAR_owner_user_id`).
- **Repo public : zéro secret, zéro tfstate ici, jamais.** Les secrets vivent dans
  `~/.config/scw/config.yaml`, `~/.aws/credentials` (profil `scaleway`) et les
  secrets GitHub Actions. Ne jamais afficher un secret dans une conversation :
  pipe direct (`curl → gh secret set`).

## Leçons

Après toute correction de Julien, mettre à jour `tasks/lessons.md` avec la règle
générale qui évite de reproduire l'erreur.
