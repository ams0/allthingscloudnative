# Tutorial: How to access the Kubernetes API from a pod

Kubernetes by default exposes its own API server to workloads within the cluster via a special service in the `default` namespace.


## Access the API

The service `kubernetes` in the `default` namespace has no selector, and it's created by the API server itself at startup; it has an hardcoded endpoint pointing to the internal IP of the API server.

We can run an unprivileged pod in the default namespace and access the token:

```bash
kubectl run -it --tty --rm debug --image=curlimages/curl --restart=Never -- sh
```

Now curl the API endpoint; notice the use of the variable substitution (Kubernetes automatically populates a number of env vars into each pod):

```bash
curl --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
     -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
     https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT
```

You'll get a request denied, but you have accessed the API nonetheless:


```bash
{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {},
  "status": "Failure",
  "message": "forbidden: User \"system:serviceaccount:default:default\" cannot get path \"/\"",
  "reason": "Forbidden",
  "details": {},
  "code": 403
}
```

You'll need to assign a (cluster)role and a (cluster)rolebinding to the Service Account to make it work.


