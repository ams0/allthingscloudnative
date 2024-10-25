# ConfigMaps and Secrets

## Introduction

ConfigMaps and Secrets

## ConfigMaps

Create a ConfigMap using both literals and files:

```bash
$ echo m > primary/magenta
$ echo y > primary/yellow
$ echo k > primary/black
$ echo "known as key" >> primary/black
$ echo blue > favorite

$ kubectl create configmap colors \
--from-literal=text=black \
--from-file=./favorite \
--from-file=./primary/

configmap/colors created

$ kubectl get configmap colors
$ kubectl get configmap colors -o yaml
```

Create a simple pod that consumes the ConfigMap

```bash
$|kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: shell-demo
spec:
  containers:
  - name: nginx
    image: nginx
    env:
    - name: ilike
      valueFrom:
        configMapKeyRef:
          name: colors
          key: favorite
EOF
```

Extract the information from the pod:

```bash
$ kubectl exec shell-demo -- /bin/bash -c 'echo $ilike'
blue
```



## Secrets