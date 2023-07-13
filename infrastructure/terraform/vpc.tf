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

# Global Static Public IP
resource "google_compute_address" "kubi-cloud-ingress-ip" {
  project      = google_project.kubi-cloud.project_id
  name         = "kubi-cloud-ingress"
  address_type = "EXTERNAL"
  region       = var.gcp_region
  depends_on   = [module.kube-api]
}

# Private VPC for GKE cluster
resource "google_compute_network" "kubi-cloud-gke-vpc" {
  project                 = google_project.kubi-cloud.project_id
  name                    = "${google_project.kubi-cloud.project_id}-private-vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
  depends_on              = [module.kube-api]
}

# VPC Subnet for services & pods
resource "google_compute_subnetwork" "gke-subnet" {
  project       = google_project.kubi-cloud.project_id
  name          = "${google_project.kubi-cloud.project_id}-private-subnet"
  region        = var.gcp_region
  network       = google_compute_network.kubi-cloud-gke-vpc.name
  ip_cidr_range = "10.10.11.0/24"

  secondary_ip_range = [
    {
      range_name    = "services"
      ip_cidr_range = "10.10.12.0/24"
    },
    {
      range_name    = "pods"
      ip_cidr_range = "10.12.0.0/20"
    }
  ]

  private_ip_google_access = true
  depends_on               = [module.kube-api]
}

# # Declare the private address from which the Cloud SQL instance is accessible from the VPC armis-vpc
# resource "google_compute_global_address" "private-ip-peering" {
#   project       = google_project.armis.project_id
#   name          = "vpc-peering-with-database-reference-api"
#   purpose       = "VPC_PEERING"
#   address_type  = "INTERNAL"
#   prefix_length = 24
#   network       = google_compute_network.armis-gke-vpc.id
#   depends_on    = [module.kube-api]
# }

# resource "google_service_networking_connection" "private-vpc-connection" {
#   network = google_compute_network.armis-gke-vpc.id
#   service = "servicenetworking.googleapis.com"
#   reserved_peering_ranges = [
#     google_compute_global_address.private-ip-peering.name
#   ]
#   depends_on = [module.kube-api]
# }