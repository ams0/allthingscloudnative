# Custom Resource Definitions

## Check what CRDs are


```bash
$ kubectl get crd

$ kubectl get crd <crd> -o yaml
```

Get instances of a specific crd

```bash
$ kubectl get <crd_name> -A
```


## Node debugging

```bash
$ kubectl debug node/node_name --it --image bash
```

Or use the `node-admin` krew plugin. Another cool trick:

```bash
kubectl run h0nk --rm -it \
 --image alpine --privileged \
 --overrides '{"spec":{"hostPID": true}}'\
 --command nsenter – \
 --mount=/proc/1/ns/mnt
```

From [Ian Coldwater tweet ](https://x.com/IanColdwater/status/1545065196561080321)

