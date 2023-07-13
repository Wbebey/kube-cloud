######
###
# Management of GKE resources
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
###
######

# GKE private cluster
resource "google_container_cluster" "kubi-cloud-gke-private" {
  project    = google_project.kubi-cloud.project_id
  name       = "kubi-cloud-gke-private"
  location   = var.gcp_region
  network    = google_compute_network.kubi-cloud-gke-vpc.name
  subnetwork = google_compute_subnetwork.gke-subnet.name

  # Declare default range IP for ControlPlane GKE
  # Set the cluster as a private GKE cluster
  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.gke-master-ipv4
  }

  # Add IP addresses will be authorized to call the Kubernetes API
  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.authorized-source-ranges
      content {
        cidr_block   = cidr_blocks.value.block
        display_name = cidr_blocks.value.name
      }
    }
  }

  # Declaratio of two subnets in the VPC. On for pods and one for services
  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  # Enable the vertical pod autoscaling
  vertical_pod_autoscaling {
    enabled = true
  }

  maintenance_policy {
    recurring_window {
      start_time = "2021-07-13T00:00:00Z"
      end_time   = "2050-01-01T04:00:00Z"
      recurrence = "FREQ=WEEKLY"
    }
  }


  # Enable Autopilot for this cluster
  enable_autopilot = true

  # Configuration options for the Release channel feature
  release_channel {
    channel = "REGULAR"
  }

  # Add some labels
  resource_labels = {
    managed_by = "terraform"
  }

  depends_on = [module.kube-api]

}

//resource "null_resource" "connect-armis-gke-private" {
//  provisioner "local-exec" {
//    command = "gcloud container clusters get-credentials $cluster_name --region europe-west1 --project $project"
//    environment = {
//      project        = google_project.armis.id
//      cluster_name   = google_project.armis.name
//    }
//  }
//  depends_on = [google_container_cluster.armis-gke-private]
//}