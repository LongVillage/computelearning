terraform {
  required_version = ">= 1.6"

  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.60"
    }
  }
}

provider "scaleway" {
  # Credentials lus depuis ~/.config/scw/config.yaml ou les variables
  # d'environnement SCW_ACCESS_KEY / SCW_SECRET_KEY / SCW_DEFAULT_PROJECT_ID.
  # Aucun secret dans ce repo (public).
  region = "fr-par"
  zone   = "fr-par-1"
}
