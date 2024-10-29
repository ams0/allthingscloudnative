# Volumes

Make sure you have a storage class in your cluster! You can install the local-storage-provisioner:

```bash
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.30/deploy/local-path-storage.yaml
```

Create a PV:

```bash
cat <<EOF | k apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-volume
spec:
  persistentVolumeReclaimPolicy: Delete
  storageClassName: "local-path"
  claimRef:
    name: pv-claim
    namespace: default
  hostPath:
    path: "/mnt/data"
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
EOF
```

Create a PVC:

```bash
cat <<EOF | k apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pv-claim
  namespace: default
spec:
  storageClassName: "local-path"
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
EOF
```

Create the pod:

```bash
cat <<EOF | k apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: pv-pod
spec:
  containers:
    - name: pv-container
      image: nginx
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: pv-storage
  volumes:
    - name: pv-storage
      persistentVolumeClaim:
        claimName: pv-claim
EOF
```




