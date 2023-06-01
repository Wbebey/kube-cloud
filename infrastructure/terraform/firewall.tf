resource "google_compute_firewall" "ssh-firewall" {
  name    = "allow-ssh-kube"
  project = google_project.kubi-cloud.project_id
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = "default"
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}