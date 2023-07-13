### Project private VPC

resource "google_compute_network" "kube_vpc_network" {
  name                    = "kube-cloud-network"
  project                 = google_project.kubi-cloud.project_id
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "kube_vpc_subnetwork" {
  name          = "kube-cloud-subnetwork"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.gcp_region
  network       = google_compute_network.kube_vpc_network.self_link
  project       = google_project.kubi-cloud.project_id
}
