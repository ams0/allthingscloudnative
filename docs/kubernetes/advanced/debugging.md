# Debugging

## Pod debugging

```bash
$ kubectl exec -it broken-pod -- sh
```

Make sure the shell exists! And containers need to be running, if they keep crashing this is pretty useless. You can attach a debug pod:

```bash
$ kubectl debug -it --image bash restarting-pod #(or nicolaka/netshoot) 
```

