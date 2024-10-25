# Network Policies

## Let's demostrate the power of Network Policies

Create an `nginx` deployment and expose its service:

```bash
kubectl create deploy nginx --replicas 2 --image nginx
kubectl expose deploy nginx --port 80
```

Create a busybox pod:

```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: busybox
spec:
  containers:
  - command:
    - sh
    - -c
    - while true; do echo hello; sleep 10;done
    image: busybox
    name: busybox
EOF


Create a policy to block all traffic to nginx pods except for pods with label access=true

```bash
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: access-nginx
spec:
  podSelector:
    matchLabels:
      app: nginx
  ingress:
  - from:
    - podSelector:
        matchLabels:
          access: "true"
EOF
```

Allow the busybox pod to access nginx pods 

```bash
kubectl label po busybox access=true
```


