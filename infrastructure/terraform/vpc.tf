### VPC

# Create a VPC Kube-1
resource "google_compute_instance" "vm-kube-1" {
  name           = "vm-kube-1"
  machine_type   = "e2-standard-2"
  zone           = "${var.gcp_region}-b"
  project        = google_project.kubi-cloud.project_id
  tags           = ["ssh", "app"]
  can_ip_forward = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  # metadata = {
  #   ssh-keys       = "${split("@", data.google_client_openid_userinfo.admin-user-info.email)[0]}:${file(var.admin-ssh-key)}"
  #   startup-script = "sudo apt-get update && sudo apt-get install -y curl && curl -sSL https://get.docker.com/  | sh &&  sudo usermod -aG docker voltron-terraform-admin  && sudo systemctl restart docker"
  # }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.public-ip-vm-kube-1.address
    }
  }
}
