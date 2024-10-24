# Deploy a cluster with minikube

Visit [minikube website](https://minikube.sigs.k8s.io/docs/start/?arch=%2Fmacos%2Farm64%2Fstable%2Fbinary+download) and choose your operating system and architecture; it'll give you a set of commands to execute:

```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
```

After that, create a simple single-node, docker-based cluster:

```bash
$ minikube start
```

Check the cluster is alive

```bash
$ kubectl cluster-info

$ kubectl 


