# Access pods' logs

## Outcomes

You should be able to:
- Access pods' logs
- Understand how to debug a pod

## Outline

1. Access pods' logs

```bash
kubectl logs nginx-<TAB>
kubectl logs nginx-<TAB> -f
kubectl logs nginx-<TAB> --previous
```

2. Access pods' logs using kubectl exec

```bash
kubectl exec -it nginx-<TAB> -- /bin/bash
> ls
> cat /var/log/nginx/access.log
> exit
```
