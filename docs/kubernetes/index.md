# Getting started with Kubernetes

## Outcomes

You should be able to:

- Understand the install and use a Kubernetes runtime and client
- Deploy a simple application
- Understand how to scale an application

## Outline

1. Run Kubernetes

You can choose your tools but we recommend either [minikube](https://github.com/kubernetes/minikube), [kind](https://kind.sigs.k8s.io) or [microk8s](https://microk8s.io)

```bash
minikube start
```

or more fancy:

```bash
minikube start --kubernetes-version=v1.28.0-rc.1 --nodes 3
```

Enable the dashboard and the metrics server:

```bash
minikube addons enable metrics-server
minikube addons enable dashboard
minikube dashboard
```

Go ahead and deploy a `redis` image using the UI. Access Redis with:

```bash
$ kubectl get pods
$ kubectl logs redis‐5o0i8
$ kubectl exec ‐ti redis‐5o0i8 bash root@redis‐5o0i8:/data# redis‐cli 127.0.0.1:6379>
```

You can use `minikube ssh` to poke around the nodes; check which node the pod is running on:

```bash
$ kubectl get pods ‐o wide
```

Explore `kubectl` commands:

```bash
$ kubectl explain pods
$ kubectl explain pods.metadata
$ kubectl describe pods redis‐7f5f77dc44‐mpjvc
```

