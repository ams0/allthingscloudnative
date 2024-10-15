# Secrets Management
Kubernetes provides a mechanism for managing sensitive information such as passwords, OAuth tokens, and SSH keys using Secrets. However, by default, Secrets are stored unencrypted in etcd.

## Example: Using Kubernetes Secrets
The following example demonstrates how to create and use a Kubernetes Secret for storing a database password:

Create the Secret:

```bash
kubectl create secret generic db-password --from-literal=password=secret123
```

Reference the Secret in a Pod:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: db-pod
spec:
  containers:
  - name: db-container
    image: mysql:5.7
    env:
    - name: MYSQL_ROOT_PASSWORD
      valueFrom:
        secretKeyRef:
          name: db-password
          key: password
```