terraform {
  # cloud {
  #   organization = "yakow"

  #   workspaces {
  #     name = "kube"
  #   }
  # }
  # backend "remote" {
  #   hostname     = "app.terraform.io"
  #   organization = "yakow"

  #   workspaces {
  #     name = "kube"
  #   }
  # }
  backend "gcs" {
    bucket = "terraform-bucket-state-001"
    prefix = "state/"
  }
}

# credentials "app.terraform.io" {
#   token = var.terraform_cloud_token
# }

resource "google_storage_bucket" "terraform-bucket-state" {
  project       = var.gcp_kube_project_id
  name          = "terraform-bucket-state-001"
  location      = var.gcp_region
  storage_class = "REGIONAL"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  labels = {
    "managed-by" = "terraform"
    "department" = "infra"
    "group"      = "kube"
  }
}


