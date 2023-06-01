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
#   token = var.terraform-cloud-token
# }

resource "google_storage_bucket" "terraform-bucket-state" {
  project       = var.gcp-kube-project-id
  name          = "terraform-bucket-state-001"
  location      = var.gcp-region
  storage_class = "REGIONAL"

  versioning {
    enabled = true
  }

  labels = {
    "managed-by" = "terraform"
    "department" = "infra"
    "group"      = "kube"
  }
}


