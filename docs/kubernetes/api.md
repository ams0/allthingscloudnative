# Explore the Kubernetes API

## Outcomes

- Understand the Kubernetes API
- Query the Kubernetes API using kubectl and curl

## Outline

Increase verbosity of kubectl output

```bash
kubectl get pods -v=8
```

Notice the `curl` command at the top of the output; save it as you'll need it later.

Create a service account and cluster role binding

```bash
kubectl create serviceaccount k8s-api-explorer
kubectl create clusterrolebinding k8s-api-explorer --clusterrole=cluster-admin --serviceaccount=default:k8s-api-explorer
```

Get the token for the service account

```bash
TOKEN=$(kubectl create token k8s-api-explorer -o jsonpath='{.data.token}')
```

Now construct the curl command to query the API

```bash
curl -k -v -XGET -H "Authorization: Bearer ${TOKEN}" <URL from command above>
```
