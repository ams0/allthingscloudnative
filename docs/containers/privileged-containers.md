# Privileged Containers

## Outcomes

You should be able to:

- Understand how to limit container capabilities

#Outline

Create a container that drops the CHOWN capability:

```bash
$ docker run ‐‐rm ‐it ‐‐cap‐drop=CHOWN busybox chown ‐R nobody:
chown: /bin/true: Operation not permitted
chown: /bin/getty: Operation not permitted
chown: /bin/hd: Operation not permitted
chown: /bin/mknod: Operation not permitted
```

You can drop all caps and add them back in one by one: 

```bash
docker run ‐d ‐‐cap‐drop=all
              ‐‐cap‐add=setuid
              ‐‐cap‐add=setgid busybox top
```

!!! note

    Privliedged containers are not recommended for production use.