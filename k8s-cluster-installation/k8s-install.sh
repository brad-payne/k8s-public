#!/bin/bash

# 1) Install Kubernetes on a Ubuntu machine
# Need to run these commands explicitly as root, and not sudo for some reason:
sudo -i
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list
apt update

apt install -y kubelet kubeadm kubectl
kubeadm init --pod-network-cidr=10.244.0.0/16  # Flannel pod network, see below
exit

# 2) Prepare kubectl for non-root user on this machine:
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
echo "source <(kubectl completion bash); alias k=kubectl; complete -F __start_kubectl k" >> .bashrc && exec $SHELL

# 3) In order to manage this instance from a remote machine, you will need to install kubectl, and get that file
# that was just copied  ()~/.kube/config) over to the remote machine. It is plain text, and you can see that it's
# a config file that uses a token for the admin user for authenticating with the cluster.


# 3) Finalize K8s config
kubectl cluster-info
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl get nodes -o wide

# For details, see:
# - https://kubernetes.io/docs/setup/independent/install-kubeadm/
# - https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/

#After install - kubectl will be the tool used to interact the cluster. Do not spend time trying to find/enable a gui admin for the cluster (dashboard) at this point.
# For a simple local install - I use deployments with ingress-types of nodeport and haven't found it worth the time to configure ingress LB's - for that you can just
# use EKS
