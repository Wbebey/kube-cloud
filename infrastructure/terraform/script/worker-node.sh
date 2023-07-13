#!/bin/bash

# Docker installation
function docker_config() {
  sudo apt-get update
  sudo apt-get install -y curl
  curl -sSL https://get.docker.com/ | sh
  sudo usermod -aG docker admin-terraform-kubi-zdt
  sudo systemctl restart docker
}

# Kubernetes installation 
function kubernetes_config() {
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
  sudo apt-get update
  sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni

  # Join the cluster
  # Make sure to copy the join-command.sh file from the master node to this node
  sudo bash join-command.sh
}


main() {
  # docker_config
  kubernetes_config
}

main