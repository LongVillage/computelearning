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
resource "scaleway_object_bucket_policy" "site" {
  bucket     = scaleway_object_bucket.site.id
  project_id = var.project_id

  policy = jsonencode({
    Version = "2023-04-17"
    Statement = [
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

# Pas de fqdns : on sert sur le domaine par défaut fourni par Scaleway
# (default_fqdn en output). Un futur domaine = ajouter fqdns ici.
resource "scaleway_edge_services_dns_stage" "site" {
  pipeline_id  = scaleway_edge_services_pipeline.site.id
  tls_stage_id = scaleway_edge_services_tls_stage.site.id
  project_id   = var.project_id
}

resource "scaleway_edge_services_head_stage" "site" {
  pipeline_id   = scaleway_edge_services_pipeline.site.id
  head_stage_id = scaleway_edge_services_dns_stage.site.id
}
