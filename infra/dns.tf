# Domaine onverraplustard.eu — acheté chez Scaleway, zone DNS dans ce projet.
# Edge Services exige un CNAME vers le endpoint du pipeline ; l'apex utilise
# un ALIAS (CNAME-at-apex du DNS Scaleway).

resource "scaleway_domain_record" "www" {
  dns_zone = var.domain
  name     = "www"
  type     = "CNAME"
  data     = "${scaleway_edge_services_dns_stage.site.default_fqdn}."
  ttl      = 3600
}

resource "scaleway_domain_record" "apex" {
  dns_zone = var.domain
  name     = ""
  type     = "ALIAS"
  data     = "${scaleway_edge_services_dns_stage.site.default_fqdn}."
  ttl      = 3600
}
