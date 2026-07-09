terraform {
  backend "s3" {
    bucket = "computelearning-tfstate"
    key    = "computelearning/terraform.tfstate"
    region = "fr-par"

    endpoints = {
      s3 = "https://s3.fr-par.scw.cloud"
    }

    # Le backend s3 vise AWS par défaut ; ces flags le rendent compatible
    # Object Storage Scaleway. Credentials via ~/.aws/credentials ou
    # AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY (mêmes clés que SCW_*).
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
  }
}
