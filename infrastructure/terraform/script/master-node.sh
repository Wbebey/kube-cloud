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
  #Install Kubernetes packages
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
  sudo apt-get update

  # Install Kubernetes components
  sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni

  # Initialize Kubernetes
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 | tee kubeadm_init.out

  # Setup kubeconfig
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

  # Install Flannel
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

  # Save the kubeadm join command to a file
  cat kubeadm_init.out | grep "kubeadm join" > join-command.sh

}


main() {
  # docker_config
  kubernetes_config
}

main