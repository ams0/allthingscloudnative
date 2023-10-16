# Expose an application inside the cluster

## Outcomes

You should be able to:
 - Expose an application inside the cluster
 - Reach the application from outside the cluster (using kubectl port-forward)
 - Understand the different types of services

## Outline

1. Expose an application inside the cluster

```bash
kubectl expose deployment nginx --port=80 --target-port=80
kubectl get services
kubectl describe service nginx
```

2. Reach the application from another pod:

```bash
kubectl run tmp-shell  --rm -i --tty --image nicolaka/netshoot -- /bin/bash
> curl nginx
```

3. Reach the application from outside the cluster (using kubectl port-forward)

```bash
kubectl port-forward service/nginx 8080:80 &
curl localhost:8080

#to kill the process
fg
#CTRL+C
```
