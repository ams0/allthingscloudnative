# Privileged Containers

## Outcomes

You should be able to:

- Understand how to limit container capabilities


```bash
$ docker run ‐‐rm ‐it ‐‐cap‐drop=CHOWN busybox chown ‐R nobody:
chown: /bin/true: Operation not permitted
chown: /bin/getty: Operation not permitted
chown: /bin/hd: Operation not permitted
chown: /bin/mknod: Operation not permitted
```

```bash
docker run ‐d ‐‐cap‐drop=all
              ‐‐cap‐add=setuid
              ‐‐cap‐add=setgid <image>
```
