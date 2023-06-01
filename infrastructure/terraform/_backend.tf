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
    bucket = "terraform-state"
    prefix = "state/"
  }
}

# credentials "app.terraform.io" {
#   token = var.terraform-cloud-token
# }

resource "google_storage_bucket" "terraform-state" {
  project       = var.gcp-infra-project-id
  name          = "terraform-state"
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


