#!/bin/bash

set -e

echo "Installing containerd..."

sudo apt-get update -y

sudo apt-get install -y containerd

sudo mkdir -p /etc/containerd

containerd config default | sudo tee /etc/containerd/config.toml >/dev/null

sudo sed -i \
's/SystemdCgroup = false/SystemdCgroup = true/' \
/etc/containerd/config.toml

sudo systemctl restart containerd

sudo systemctl enable containerd

echo "Containerd installation completed."

echo "Installing Kubernetes packages..."

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | \
sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | \
sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update -y

sudo apt-get install -y \
kubelet \
kubeadm \
kubectl

sudo apt-mark hold \
kubelet \
kubeadm \
kubectl

sudo systemctl enable kubelet

echo "Kubernetes packages installed."
