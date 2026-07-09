output "site_url" {
  description = "URL publique du site (endpoint par défaut Edge Services)"
  value       = "https://${scaleway_edge_services_dns_stage.site.default_fqdn}"
}

output "site_bucket" {
  description = "Bucket cible du déploiement (aws s3 sync)"
  value       = scaleway_object_bucket.site.name
}

output "deploy_application_id" {
  description = "Application IAM github-deploy — créer sa clé API à la main"
  value       = scaleway_iam_application.github_deploy.id
}
