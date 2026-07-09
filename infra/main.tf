# Le site : un bucket Object Storage servi en HTTPS par Edge Services.
#
#   GitHub Actions ──s3 sync──> bucket (website) ──pipeline Edge──> HTTPS public
#
# Chaîne du pipeline : head → DNS → TLS → cache → backend (bucket).

resource "scaleway_object_bucket" "site" {
  name       = var.site_bucket_name
  project_id = var.project_id
}

# Mode website : résout /medias/ vers /medias/index.html (Astro génère des
# répertoires) et sert 404.html sur les chemins inconnus.
resource "scaleway_object_bucket_website_configuration" "site" {
  bucket     = scaleway_object_bucket.site.id
  project_id = var.project_id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

# Lecture publique des objets (site public) — pas de listing du bucket.
# Attention (spécificité Scaleway) : une bucket policy révoque tout ce qu'elle
# n'autorise pas explicitement, y compris pour le propriétaire — d'où le
# statement OwnerFullAccess, sans quoi on se verrouille dehors.
resource "scaleway_object_bucket_policy" "site" {
  bucket     = scaleway_object_bucket.site.id
  project_id = var.project_id

  # La config website doit passer avant que la policy ne restreigne quoi que ce soit.
  depends_on = [scaleway_object_bucket_website_configuration.site]

  policy = jsonencode({
    Version = "2023-04-17"
    Statement = [
      {
        Sid    = "OwnerAndDeployFullAccess"
        Effect = "Allow"
        Principal = {
          SCW = [
            "user_id:${var.owner_user_id}",
            "application_id:${scaleway_iam_application.github_deploy.id}",
          ]
        }
        Action = ["*"]
        Resource = [
          var.site_bucket_name,
          "${var.site_bucket_name}/*",
        ]
      },
      {
        Sid       = "PublicReadObjects"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = ["${var.site_bucket_name}/*"]
      }
    ]
  })
}

# Edge Services — plan Starter : 1 pipeline, 100 GB de cache, 0,99 €/mois.
resource "scaleway_edge_services_plan" "main" {
  name       = "starter"
  project_id = var.project_id
}

resource "scaleway_edge_services_pipeline" "site" {
  name        = "computelearning"
  description = "Sert le site statique computelearning depuis le bucket Object Storage"
  project_id  = var.project_id

  depends_on = [scaleway_edge_services_plan.main]
}

resource "scaleway_edge_services_backend_stage" "site" {
  pipeline_id = scaleway_edge_services_pipeline.site.id
  project_id  = var.project_id

  s3_backend_config {
    bucket_name   = scaleway_object_bucket.site.name
    bucket_region = "fr-par"
    is_website    = true
  }
}

resource "scaleway_edge_services_cache_stage" "site" {
  pipeline_id      = scaleway_edge_services_pipeline.site.id
  backend_stage_id = scaleway_edge_services_backend_stage.site.id
  project_id       = var.project_id

  # 1 h : bon compromis pour un site mis à jour par push occasionnel,
  # sans purge automatisée en v1.
  fallback_ttl = 3600
}

resource "scaleway_edge_services_tls_stage" "site" {
  pipeline_id    = scaleway_edge_services_pipeline.site.id
  cache_stage_id = scaleway_edge_services_cache_stage.site.id
  project_id     = var.project_id

  managed_certificate = true
}

# Sert sur le domaine custom (certificat Let's Encrypt managé par le tls_stage)
# et sur le default_fqdn Scaleway, qui reste actif en parallèle.
resource "scaleway_edge_services_dns_stage" "site" {
  pipeline_id  = scaleway_edge_services_pipeline.site.id
  tls_stage_id = scaleway_edge_services_tls_stage.site.id
  project_id   = var.project_id

  # Apex volontairement absent : le contrôle d'Edge exige un vrai CNAME, or un
  # ALIAS s'aplatit en A — le warning dns_cname_resolve bloque l'émission du
  # certificat pour tout le set. www est l'URL canonique.
  fqdns = [
    "www.${var.domain}",
  ]
}

resource "scaleway_edge_services_head_stage" "site" {
  pipeline_id   = scaleway_edge_services_pipeline.site.id
  head_stage_id = scaleway_edge_services_dns_stage.site.id
}
