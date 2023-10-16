# Use podman to run containers

## Outcomes

You should be able to:
- Understand how to run containers with podman
- Understand how to run containers with podman-compose
- Understand how to run containers with podman-pod

## Outline

1. Run a container with podman using the `ubi` image (the `ubi` image is a minimal image based on [Red Hat Universal Base Image](https://catalog.redhat.com/software/containers/ubi8/ubi/5c359854d70cc534b3a3784e?architecture=amd64&image=651ed985e6a2039b142a63ae))

```bash
podman run --rm -it ubi bash
```

Notice the use of the `--rm` flag. This flag will remove the container once it exits. Also, note the use of the `-it` flags. These flags are used to run the container interactively and to allocate a pseudo-TTY.