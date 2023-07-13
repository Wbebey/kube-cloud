######
###
# Management of CloudNat resources
###
######

# Declare a basic IP address
resource "google_compute_address" "gke-address" {
  project    = google_project.kubi-cloud.project_id
  name       = "gke-address"
  region     = var.gcp_region
  depends_on = [module.kube-api]

}

# Declaration of the network to which this router belongs
resource "google_compute_router" "gke-router" {
  project    = google_project.kubi-cloud.project_id
  name       = "gke-router"
  region     = var.gcp_region
  network    = google_compute_network.kubi-cloud-gke-vpc.id
  depends_on = [module.kube-api]
}

# Declare the Cloud Router to allow GKE instances (Nodes) without external IP addresses outbound create connections to the internet.
resource "google_compute_router_nat" "gke-router-nat-for-gke-instances" {
  project                            = google_project.kubi-cloud.project_id
  region                             = var.gcp_region
  name                               = "gke-router-nat-for-gke-instances"
  router                             = google_compute_router.gke-router.name
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.gke-address.self_link]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.gke-subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  depends_on = [google_compute_address.gke-address, module.kube-api]
}