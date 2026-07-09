# Infra — computelearning

Hébergement du site statique sur Scaleway, ~1 €/mois :

```
GitHub (push main) ──Actions──> bucket S3 privé (fr-par) ──Edge Services──> HTTPS public
                                 computelearning-site       plan Starter (0,99 €/mois)
```

**Règle absolue : ce repo est public — aucun secret, aucun tfstate ici.**
Le state vit dans le bucket privé `computelearning-tfstate` ; les credentials
vivent dans `~/.config/scw/config.yaml`, `~/.aws/credentials` et les secrets
GitHub Actions.

## Bootstrap (une seule fois)

1. Compte + projet Scaleway (console), puis une **clé API admin** (IAM → API keys).
2. Dans **ton terminal** (pas dans une conversation — les secrets n'ont rien à y faire) :

   ```sh
   # Provider Scaleway (terraform plan/apply locaux)
   mkdir -p ~/.config/scw
   cat > ~/.config/scw/config.yaml <<EOF
   access_key: SCWXXXXXXXXXXXXXXXXX
   secret_key: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
   default_project_id: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
   default_region: fr-par
   default_zone: fr-par-1
   EOF
   chmod 600 ~/.config/scw/config.yaml

   # Backend s3 du state + aws s3 sync (mêmes clés)
   mkdir -p ~/.aws
   cat >> ~/.aws/credentials <<EOF
   [default]
   aws_access_key_id = SCWXXXXXXXXXXXXXXXXX
   aws_secret_access_key = xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
   EOF
   chmod 600 ~/.aws/credentials

   export TF_VAR_project_id="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
   export TF_VAR_owner_user_id="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"  # IAM → Users
   ```

   Si `~/.aws/credentials` sert déjà à autre chose, utiliser un profil dédié
   `[scaleway]` et préfixer les commandes par `AWS_PROFILE=scaleway`.

3. Créer le bucket du state (hors Terraform, volontairement) :

   ```sh
   aws s3api create-bucket --bucket computelearning-tfstate \
     --endpoint-url https://s3.fr-par.scw.cloud --region fr-par
   ```

4. `terraform init && terraform plan && terraform apply` depuis `infra/`.

5. Clé API pour le déploiement GitHub : une clé portée par l'application
   `github-deploy-computelearning` (créée par Terraform, id dans
   `terraform output`), avec date d'expiration (exigée par l'organisation).
   Sans jamais afficher le secret :

   ```sh
   RESP=$(curl -s -X POST -H "X-Auth-Token: $SCW_SECRET_KEY" -H "Content-Type: application/json" \
     -d '{"application_id":"<app-id>","description":"GitHub Actions deploy","expires_at":"2027-07-09T00:00:00Z"}' \
     https://api.scaleway.com/iam/v1alpha1/api-keys)
   echo "$RESP" | python3 -c "import json,sys; print(json.load(sys.stdin)['access_key'], end='')" | gh secret set SCW_ACCESS_KEY
   echo "$RESP" | python3 -c "import json,sys; print(json.load(sys.stdin)['secret_key'], end='')" | gh secret set SCW_SECRET_KEY
   ```

   Clé actuelle : expire le 2027-07-09 — la renouveler avant.

## Domaine

`onverraplustard.eu` est acheté chez Scaleway (zone DNS dans le même projet,
records en Terraform dans `dns.tf`). **URL canonique : https://www.onverraplustard.eu**
(CNAME → pipeline Edge, certificat Let's Encrypt managé, renouvelé par Scaleway).
L'apex nu a un ALIAS mais n'est pas dans les `fqdns` du pipeline : le contrôle
d'Edge exige un vrai CNAME et un ALIAS s'aplatit en A, ce qui bloquait
l'émission du certificat pour tout le set.

## Au quotidien

- Déploiement du site : automatique à chaque push sur `main`
  (`.github/workflows/site.yml`). Cache Edge : TTL 1 h, pas de purge auto en v1.
- Évolution de l'infra : modifier ici, `terraform plan` puis `apply` en local.
  `TF_VAR_project_id` doit être exporté.
- URL du site : `terraform output site_url`.
