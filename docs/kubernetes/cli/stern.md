# Install Stern to access pod logs

[Stern](https://github.com/stern/stern) is a tool that allows you to tail multiple pods on Kubernetes and multiple containers within the pod. Each result is color coded for quicker debugging.

1. Install Stern

    ```bash
    curl -L -o /usr/local/bin/stern
    chmod +x /usr/local/bin/stern
    ```

2. Install on MacOS

```bash
brew install stern
```