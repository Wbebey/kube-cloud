### Firewall rules

# Allow SSH from anywhere
resource "google_compute_firewall" "ssh-firewall" {
  name    = "allow-ssh-kube"
  project = google_project.kubi-cloud.project_id
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.kube_vpc_network.name
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

# Allow HTTP and HTTPS from anywhere
resource "google_compute_firewall" "application-firewall" {
  name    = "allow-application-firewall-kube"
  project = google_project.kubi-cloud.project_id
  network = google_compute_network.kube_vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["app"]
}

# Allow kubernetes port
resource "google_compute_firewall" "kubernetes-firewall" {
  name    = "allow-kubernetes-firewall-kube"
  project = google_project.kubi-cloud.project_id
  network = google_compute_network.kube_vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["6443"]
  }
  allow {
    protocol = "udp"
    ports    = ["6443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["kube"]
}