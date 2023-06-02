terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  region = var.gcp_region
  credentials = var.service_account_gcp
}
