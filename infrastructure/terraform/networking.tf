### Networking

# Create a VPC network
resource "google_compute_address" "public-ip-vm-kube" {
  count   = length(var.vm_names)
  name    = "${var.vm_names[count.index]}-ip"
  project = google_project.kubi-cloud.project_id
  region  = var.gcp_region
}