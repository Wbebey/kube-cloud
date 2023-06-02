### Networking

# Create a VPC network for vm-kube-1
resource "google_compute_address" "public-ip-vm-kube-1" {
  project      = google_project.kubi-cloud.project_id
  name         = "public-ip-vm-kube-1"
  address_type = "EXTERNAL"
  region       = var.gcp_region
  depends_on   = [module.kube-api]
}