# Common variables

variable "gcp_region" {
  type        = string
  description = "Default region to use"
  sensitive   = true
}

variable "gcp_billing_account_id" {
  type        = string
  description = "The GCP billing account id"
  sensitive   = true
}

variable "gcp_org_id" {
  type        = string
  description = "The GCP organization id"
  sensitive   = true
}

variable "gcp_kube_project_id" {
  type        = string
  description = "The GCP  project id"
  sensitive   = false
}

variable "terraform_cloud_token" {
  type        = string
  description = "Terraform Cloud token"
  sensitive   = true
}

variable "service_account_gcp" {
  type        = string
  description = "Service account email"
  sensitive   = true
}
