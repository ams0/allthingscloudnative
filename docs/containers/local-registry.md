# Run a local registry

## Outcomes

- Run a local registry to push and pull images from
- Understand how to interact with a local registry

## Outline

Run a local registry:

```bash
docker run -d -p 5000:5000 --name registry registry:latest
```

Pull, tag and push to local registry:

```bash
docker pull ubuntu
docker tag ubuntu localhost:5000/ubuntu
docker push localhost:5000/ubuntu
```

Use crane to inspect the registry:

```bash

#install crane
VERSION=$(curl -s "https://api.github.com/repos/google/go-containerregistry/releases/latest" | jq -r '.tag_name')
ARCH=x86_64 
OS=Linux 
curl -sL "https://github.com/google/go-containerregistry/releases/download/${VERSION}/go-containerregistry_${OS}_${ARCH}.tar.gz" > go-containerregistry.tar.gz
tar -zxvf go-containerregistry.tar.gz -C /usr/local/bin/ crane


crane catalog localhost:5005
ubuntu
```


