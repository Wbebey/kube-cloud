data "google_client_openid_userinfo" "admin-user-info" {}

resource "google_compute_instance" "vm-kube" {
  count          = length(var.vm_names)
  name           = var.vm_names[count.index]
  machine_type   = var.machine_types[count.index]
  zone           = "${var.gcp_region}-b"
  project        = google_project.kubi-cloud.project_id
  tags           = ["ssh", "app", "kube"]
  can_ip_forward = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  metadata = {
    ssh-keys               = <<-EOT
      ${split("@", data.google_client_openid_userinfo.admin-user-info.email)[0]}:${var.ssh_mathieu}
      ${split("@", data.google_client_openid_userinfo.admin-user-info.email)[0]}:${var.ssh_willy}
    EOT
    startup-script         = "sudo apt-get update && sudo apt-get install -y curl && curl -sSL https://get.docker.com/ | sh && sudo usermod -aG docker admin-terraform-kubi-zdt && sudo systemctl restart docker"
    block-project-ssh-keys = "true"
  }

  network_interface {
    network    = google_compute_network.kube_vpc_network.name
    subnetwork = google_compute_subnetwork.kube_vpc_subnetwork.self_link
    access_config {
      nat_ip = google_compute_address.public-ip-vm-kube[count.index].address
    }
  }
}