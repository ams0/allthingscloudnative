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


Create a Network Policy named `net-ingress` such that only pods with label app=busybox will be about to make request to these nginx pods on port 80 .

```bash
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: net-ingress
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: nginx
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: busybox
    ports:
    - protocol: TCP
      port: 80
EOF
```

Create an Egress policy

```bash
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: net-egress
  namespace: default
spec:
  podSelector:
    matchLabels:
      run: busybox
  policyTypes:
  - Egress
  egress:
  - to:
    - podSelector:
        matchLabels:
          run: nginx
    ports:
    - protocol: TCP
      port: 8080
EOF
```


