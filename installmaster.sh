#!/bin/bash

echo "###############################"
echo "#       KUBE PI INSTALLER     #"
echo "###############################"
echo "[!] updating and installing docker..."
sudo apt update && sudo apt upgrade -y
sudo apt install docker.io -y
echo "[!] Adding keys..."
sudo apt update
sudo apt install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
echo "[!] Installing kube..."
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
echo "[!] Setting cgroups..."
sudo sed ' 1 s/.*/&cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1 net.bridge.bridge-nf-call-iptables=1/' /boot/firmware/cmdline.txt
echo "[!] Setting network stuff up..."
sudo modprobe br_netfilter
echo "[!!] uncomment net.ipv4.ip_forward=1 when editor pops up..."
sleep 3
sudo nano /etc/sysctl.conf
echo "[!] Installing containord"
sudo apt-get update
sudo apt-get install containerd
echo "[!] Starting required stuff..."
sudo systemctl enable containerd
sudo systemctl start containerd
echo "[!] Starting kubeadm init --pod-network-cidr=$1"
sudo kubeadm init --pod-network-cidr=$1
echo "[!] Installation complete!"
