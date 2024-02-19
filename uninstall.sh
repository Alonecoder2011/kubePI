#!/bin/bash

sudo kubeadm reset
sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni
sudo rm -rf /etc/kubernetes
sudo apt-get autoremove
sudo systemctl stop kubelet
sudo reboot
