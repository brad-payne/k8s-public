#!/bin/bash

dir="/home/${USER}/Downloads"
[[ -d $dir ]] || mkdir $dir

cd $dir
#install kubectl
#curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
#chmod +x ./kubectl
#sudo mv ./kubectl /usr/local/bin/kubectl

sudo apt-get update && sudo apt-get install -y apt-transport-https socat
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube

sudo install minikube /usr/local/bin 
#sudo minikube start --apiserver-ips 127.0.0.1 --apiserver-name localhost --vm-driver=none

#go replace the server ip in ~/.kube/config with "localhost" on the server: line

