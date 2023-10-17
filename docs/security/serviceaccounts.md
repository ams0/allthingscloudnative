# Kubernetes Service Accounts

## Outcomes

In this lab you will learn how to:
- Create a service account
- Use a service account to access the Kubernetes API

## Outline

1. Create a service account

```bash
$ kubectl create serviceaccount myserviceaccount
```

2. Create a pod that uses the service account

```bash
$ kubectl run mypod --image=nginx --serviceaccount=myserviceaccount
```

3. Get the token for the service account

```bash
$ kubectl get secret $(kubectl get serviceaccount myserviceaccount -o jsonpath='{.secrets[0].name}') -o jsonpath='{.data.token}' | base64 -d
```
