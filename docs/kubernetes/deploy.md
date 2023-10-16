# Deploy an application to Kubernetes

## Outcomes

You should be able to:

- Deploy a simple application

## Outline

1. Deploy a simple application

```bash
kubectl create deployment nginx --image=nginx
kubectl get deployments
kubectl describe deployment nginx
kubectl get deployment nginx -o yaml
```

2. Save the deployment to a file and re-apply it

```bash
kubectl get deployment nginx -o yaml > nginx.yaml
kubectl delete deployment nginx
kubectl apply -f nginx.yaml
kubectl get pods
```

3. Duplicate the deployment

```bash
cp nginx.yaml nginx2.yaml
sed -i 's/nginx/nginx2/g' nginx2.yaml
kubectl apply -f nginx2.yaml
kubectl delete deployment
kubectl get pods
```
