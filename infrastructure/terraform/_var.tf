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

variable "vm_names" {
  description = "Names for the VM instances"
  type        = list(string)
  default = [
    "vm-kube-10",
    "vm-kube-20",
    "vm-kube-30"
  ]
}

variable "machine_types" {
  description = "Machine types for the VM instances"
  type        = list(string)
  default = [
    "e2-standard-2",
    "e2-standard-2",
    "e2-standard-2"
  ]
}

variable "ssh_willy" {
  description = "SSH keys for willy"
  type        = string
  sensitive   = true
}

variable "ssh_mathieu" {
  description = "SSH keys for mathieu"
  type        = string
  sensitive   = true
}

variable "gke-master-ipv4" {
  type        = string
  default     = "172.23.0.0/28"
  description = "Default range IP for ControlPlane GKE"
}

variable "authorized-source-ranges" {
  type        = list(any)
  default     = [{ name = "VPN-1", block = "130.180.210.238/32" }, { name = "VPN-2", block = "91.162.97.145/32" }]
  description = "IP Addresses which are allowed to connect to GKE API Server. (VPN)"
}

variable "authorized-inbound-cluster-1" {
  type        = list(string)
  default     = ["130.180.210.238/32", "91.162.97.145/32", "8.8.4.0/24", "8.8.8.0/24"]
  description = "IP Addresses which are allowed to connect to GKE Ingress. (VPN)"
}
