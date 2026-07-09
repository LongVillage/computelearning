variable "project_id" {
  description = "ID du projet Scaleway (UUID). Fourni via TF_VAR_project_id, jamais committé."
  type        = string
}

variable "site_bucket_name" {
  description = "Nom du bucket qui contient le site buildé (unique par région Scaleway)."
  type        = string
  default     = "computelearning-site"
}
