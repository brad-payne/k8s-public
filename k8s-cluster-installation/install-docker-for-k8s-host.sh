#!/bin/bash

# [EXECUTE FILE - NO HUMAN INTERVENTION REQUIRED]


# Install Docker CE
## Set up the repository:

### Add Docker’s official GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

### Install packages to allow apt to use a repository over HTTPS
sudo apt-get update && apt-get install apt-transport-https ca-certificates curl software-properties-common -y

### Add Docker apt repository.
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

## Install Docker CE.
sudo apt-get update && apt-get install docker-ce=18.06.2~ce~3-0~ubuntu -y

# Setup daemon & Configure to use cgroupdriver of systemd, so Kubernetes doesn't complain
sudo cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

sudo mkdir -p /etc/systemd/system/docker.service.d

# Restart docker.
systemctl daemon-reload
systemctl restart docker
