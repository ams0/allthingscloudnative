# Persistent Volumes in Docker/Podman

## Outcomes

- Understand the difference between a volume and a bind mount
- Understand how to create a volume

## Outline

The "old" docker style:

```bash
docker run -v /path/to/the/volume:/path/in/the/container/fs \
        [<options>...] <image> [<command>]
```

the new podman style:

```bash
podman run  --name mycontainer \
        --mount type=bind,src=/path/on/host,dst=/path/in/container \
        [<options>...] <image> [<command>]
```

## Exercise

```
LOG_SRC=~/lab.log
LOG_DST=/var/log/dpkg.log
podman run -d --name bind-container --mount type=bind,src=$LOG_SRC,dst=$LOG_DST -p 80:80 drupal
```

We create some logs

```
podman exec -it bind-container bash
echo "This is a log from within the container" >> /var/log/dpkg.log
exit

cat lab.log
```

## Volumes

```
podman volume create volume1
podman run -d --name volume-container --mount type=volume,src=volume1,dst=/var/log -p 80:80 drupal
podman inspect volume-container
```

