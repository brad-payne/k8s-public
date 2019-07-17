#!/bin/bash

#Ubuntu 18+ doesn't get configured properly via vSphere Guest Customization due to the cloud config module
#set the hostname and ip
sudo hostnamectl set-hostname ubuntu-k8s-host

#check/set the name in the traditional hosts file
sudo vi /etc/hosts

#if cloud-init package is installed, will need to edit those
ls -l /etc/cloud/cloud.cfg
sudo vi /etc/cloud/cloud.cfg

#search for "preserve_hostname: false" This will cause the set+update hostname module to not operate (if true)
preserve_hostname: true

#I don't like entering pw for sudo in my home lab.  Add an entry - processed in order, so place in bottom of file:
# brad    ALL=(ALL:ALL) NOPASSWD:ALL
sudo visudo


#disable swap:
sudo swapon -s
sudo swapoff -a

#disable the swap line in /etc/fstab, #omment out the line for swap
sudo vim /etc/fstab
