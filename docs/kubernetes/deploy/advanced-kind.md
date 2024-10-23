# Advanced Cluster Deployment with Kind

We will use this script: [kind_cilium.sh](https://gist.github.com/ams0/4f1063be9e8d5c34fc85a1b4857aed71) to deploy a cluster with multiple nodes, support for LoadBalancer type services, and more.

Download the script:

```bash
curl -O kind_cilium.sh https://gist.githubusercontent.com/ams0/4f1063be9e8d5c34fc85a1b4857aed71/raw/2fc80bf98d66e0b265fedd77a27d6c66e3e36627/kind_cilium.sh

chmox +x kind_cilium.sh
```

Deploy a cluster with Cilium and MetalLB:

```bash
./kind_cilium.sh -n kind -t true -c true
```

Check that Cilium and MetalLB are deployed

```bash
kubectl get po -n kube-system -l app.kubernetes.io/name=cilium-agent
kubectl get po -n metallb-system
```

