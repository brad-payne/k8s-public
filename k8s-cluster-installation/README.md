#K8s Cluster info

<h1>Kubernetes Installation Docs and Scripts</h1>

The files and scripts in this directory are what I've put together for setting up K8s clusters.

<h2>Installing Kubernetes on a new Ubuntu 18.04 Install</h2>
I have installed K8s on Ubuntu mainly, and the below steps are what I've followed to get a cluster up and running. Open the files in the order listed, and execute the commands - most files are not configured to properly execute without some manual steps, if it can be executed without any human intervention, it will be stated in comment at the top of the file.

<ol type=number>
  <li>Minimal OS Configuration Required: minimal-os-config.sh</li>
  <li>Install Docker CE for Ubuntu/K8s: sudo -i; then run ./install-docker-for-k8s-host.sh (chmod +x if necssary first)</li>
  <li>Optional: Add your user to docker group: usermod -aG docker brad
  <li>Install Kubernetes: (still in sudo -i) ./k8s-repoprep-install-tools.sh, (exit root, if necessary) ./k8s-install.sh</li>
  <li>Configure remote mgmt machine: comments at bottom of k8s-install.sh</li>
  <li>Additional things to Look at:
    <li>Helm: Self-described package manager for k8s. Deploy applications very easily - when they work. I have had installs for bad, and was not able to clean up. Had to pave the cluster. In order to avoid that, you can keep tiller off of the destination k8s cluster, by running it from another machine. This allows for manual clean up of botched deployments. Also a very useful flag is the "-atomic" flag duruing install, so if something goes bad, the entire deployment is rolled back.</li>
    <li>Rancher: Custom master and optional custom OS for K8s to make K8s deployments easy</li>
  </li>

</ol>
