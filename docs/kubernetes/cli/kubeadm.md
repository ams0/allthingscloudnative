# Kubeadm

Kubeadm is a tool to install and configure the various components of a Kubernetes cluster on one or multiple nodes; it deploys the various components of the Kubernetes control plane and is the preferred tool for installing Kubernetes on bare metal.

Install Kubeadm on linux (not avaialble for MacOS or Windows):

```bash
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
```

