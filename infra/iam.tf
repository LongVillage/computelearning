# Identité du déploiement GitHub Actions : périmètre Object Storage uniquement.
# La clé API de cette application est créée À LA MAIN (console ou `scw iam
# api-key create`) pour que son secret n'entre jamais dans le state, puis posée
# dans les secrets GitHub (SCW_ACCESS_KEY / SCW_SECRET_KEY).

resource "scaleway_iam_application" "github_deploy" {
  name        = "github-deploy-computelearning"
  description = "Sync du site buildé vers le bucket, depuis GitHub Actions"
}

resource "scaleway_iam_policy" "github_deploy" {
  name           = "github-deploy-computelearning"
  description    = "Object Storage seulement, scopé au projet"
  application_id = scaleway_iam_application.github_deploy.id

  rule {
    project_ids          = [var.project_id]
    permission_set_names = ["ObjectStorageFullAccess"]
  }
}
