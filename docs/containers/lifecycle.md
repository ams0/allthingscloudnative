# Container lifecycle

## Outcomes

You should be able to:
- Understand the lifecycle of a container

## Outline

(the below can be done with docker or podman)

1. Create a container but don't run it:

```bash
docker create -p 80:80 --name web_server drupal
```

2. Start the container:

```bash
docker start web_server
```

The above two commands can be combined into one:

```bash
docker run -p 80:80 --name web_server drupal
```

3. Pause the container:

```bash
docker pause web_server
```

4. Unpause the container:

```bash
docker unpause web_server
```

5. Stop the container:

```bash
docker stop web_server
```

6. Inspect the container

```bash
docker inspect web_server
```

7. Remove the container:

```bash
docker rm web_server
docker ps -a
```