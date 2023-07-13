locals {
  ssh_private_key_path  = "~/.ssh/group-3_rsa"
  ansible_user          = "admin-terraform-kubi-zdt"
  ansible_host_path     = "ansible/config/hosts.ini"
  ansible_playbook_path = "ansible/playbooks/setup-k8s.yaml"
}

resource "local_file" "ansible_hosts" {
  content = <<-EOF
    [master]
    master10 ansible_host=${google_compute_instance.vm-kube[0].network_interface.0.access_config.0.nat_ip}

    [workers]
    worker20 ansible_host=${google_compute_instance.vm-kube[1].network_interface.0.access_config.0.nat_ip}
    worker30 ansible_host=${google_compute_instance.vm-kube[2].network_interface.0.access_config.0.nat_ip}

    [all:vars]
    ansible_python_interpreter=/usr/bin/python3
    ansible_user=${local.ansible_user}
    ansible_ssh_private_key_file=${local.ssh_private_key_path}
  EOF

  filename   = local.ansible_host_path
  depends_on = [google_compute_address.public-ip-vm-kube]
}

# resource "null_resource" "ansible_provisioner" {
#   depends_on = [
#     local_file.ansible_hosts
#   ]

#   provisioner "local-exec" {
#     command = "ansible-playbook -i ${local.ansible_host_path} ${local.ansible_playbook_path}"
#   }
# }
