# resource "google_compute_instance" "vm-master-1" {
#   name           = "vm-master-1"
#   machine_type   = "e2-stadard-2"
#   zone           = "${var.gcp-region}-b"
#   project        = var.gcp-kube-project-id
#   tags           = ["ssh", "app"]
#   can_ip_forward = true

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"
#     }
#   }
#   metadata = {
#     # ssh-keys       = "${split("@", data.google_client_openid_userinfo.admin-user-info.email)[0]}:${file(var.admin-ssh-key)}"
#     startup-script = "sudo apt-get update && sudo apt-get install -y curl && curl -sSL https://get.docker.com/  | sh &&  sudo usermod -aG docker voltron-terraform-admin  && sudo systemctl restart docker"
#   }

#   network_interface {
#     network = "default"
#   }
# }

# Create a Debian VM
resource "google_compute_instance" "debian_vm" {
  name         = "debian-vm"
  machine_type = "e2-standard-2"
  zone         = "europe-west1-b"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
  }
}