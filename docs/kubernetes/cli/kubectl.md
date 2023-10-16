# Kubectl

Install Kubectl:

Windows:

```bash
choco install kubernetes-cli
```

Linux:

```bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.21.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

MacOS:

```bash
brew install kubectl
```

Get help:

```bash
kubectl --help
kubectl help
kubectl help create

