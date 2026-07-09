variable "project_id" {
  description = "ID du projet Scaleway (UUID). Fourni via TF_VAR_project_id, jamais committé."
  type        = string
}

variable "owner_user_id" {
  description = "ID de l'utilisateur IAM propriétaire (UUID). Fourni via TF_VAR_owner_user_id."
  type        = string
}

variable "site_bucket_name" {
  description = "Nom du bucket qui contient le site buildé (unique par région Scaleway)."
  type        = string
  default     = "computelearning-site"
}
