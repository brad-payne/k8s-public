#!/bin/bash

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list
apt update

apt install -y kubelet kubeadm kubectl
kubeadm init --pod-network-cidr=10.244.0.0/16  # Flannel pod network, see below
exit #exit sudo -i
