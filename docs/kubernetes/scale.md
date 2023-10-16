# Scale an application on Kubernetes

## Outcomes

You should be able to:
- Scale an application on Kubernetes

## Outline

1. Scale an application on Kubernetes

```bash
kubectl scale deployment nginx --replicas=3
kubectl get pods
```

2. Scale an application on Kubernetes using kubectl edit

```bash
kubectl edit deployment nginx
```

3. Scale an application on Kubernetes using kubectl patch

```bash
kubectl patch deployment nginx -p '{"spec":{"replicas":2}}'
```

4. Test the resilience of the application

```bash
kubectl delete pod nginx-<TAB>
kubectl get pods
```

5. Scale an application on Kubernetes using kubectl autoscale

```bash
kubectl autoscale deployment nginx --min=2 --max=5 --cpu-percent=80
kubectl get hpa
kubectl get pods
```
