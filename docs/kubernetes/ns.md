# Namespaces

## Create a namespace

```bash
kubectl create namespace my-namespace
```

## List namespaces

```bash
kubectl get namespaces
```

## Switch namespace

```bash
kubectl config set-context --current --namespace=my-namespace
```

## Delete a namespace

```bash
kubectl delete namespace my-namespace
```
