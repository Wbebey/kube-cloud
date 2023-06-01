# Common variables

variable "gcp-region" {
  type        = string
  description = "Default region to use"
  sensitive   = true
}

variable "gcp-billing-account-id" {
  type        = string
  description = "The GCP billing account id"
  sensitive   = true
}

variable "gcp-org-id" {
  type        = string
  description = "The GCP organization id"
  sensitive   = true
}

variable "gcp-kube-project-id" {
  type        = string
  description = "The GCP  project id"
  sensitive   = true
}

variable "gcp-auth-file" {
  type        = string
  description = "GCP authentication file"
}

variable "terraform-cloud-token" {
  type        = string
  description = "Terraform Cloud token"
  # sensitive   = true
}
