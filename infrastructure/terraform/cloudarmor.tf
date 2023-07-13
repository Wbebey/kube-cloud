######
###
# Management of Cloud Armor resources
###
######

# Create a network security rules with Cloud Armor
# Allow VPN and GCP Ips to access to GKE private services exposed by External Ingress
resource "google_compute_security_policy" "inbound-kube-traffic" {
  project = google_project.kubi-cloud.project_id
  name    = "inbound-kube-traffic"

  rule {
    action   = "allow"
    priority = "1000"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = var.authorized-inbound-cluster-1
      }
    }
    description = "Allow access to authorized source ranges"
  }

  rule {
    action   = "deny(403)"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }

  depends_on = [module.kube-api]

}