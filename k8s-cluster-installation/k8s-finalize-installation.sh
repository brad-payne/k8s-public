#!/bin/bash

# 3) Finalize K8s config
kubectl cluster-info
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl get nodes -o wide
