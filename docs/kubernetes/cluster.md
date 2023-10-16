# Explore the cluster

## Outcomes

You should be able to:

- Get an idea on how Kubernetes works
- Understand the basic concepts of Kubernetes

## Outline

1. Alias kubectl

```bash
alias k=kubectl
```

2. Explore the cluster

```bash
k get nodes
k get pods
k get pods -o wide
```

3. Get cluster information

```bash
k cluster-info
k get componentstatuses
k get events
k api-resources
k api-versions
```
