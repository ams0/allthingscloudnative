# Explore and interact with registries

## Outcomes

- Understand the difference between a registry and a repository
- Understand how to interact with a registry

## Outline

(the below can be done with `podman` or `docker`)

Search a registry for an image

```bash
podman search registry.access.redhat.com <pattern>
```

Pull an image from a registry

```bash
podman pull registry.access.redhat.com/rhel7/rhel
```

Tag images

```bash
podman tag registry.access.redhat.com/rhel7/rhel rhel7/rhel
```

Push images to a registry

```bash
podman login -u <username> -p <password> <registry>:<port>
podman push rhel7/rhel <registry>:<port>/<username>/rhel7/rhel
```
