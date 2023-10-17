# Context and kubeconfig
`kubectl` allows a user to interact with and manage multiple Kubernetes clusters. To do this, it requires what is known
as a context. A context consists of a combination of `cluster`, `namespace` and `user`.
* **cluster** - A friendly name, server address, and certificate for the Kubernetes cluster.
* **namespace (optional)** - The logical cluster or environment to use. If none is provided, it will use the default
`default` namespace.
* **user** - The credentials used to connect to the cluster. This can be a combination of client certificate and key,
username/password, or token.

These contexts are stored in a local yaml based config file referred to as the `kubeconfig`. For \*nix based
systems, the `kubeconfig` is stored in `$HOME/.kube/config` for Windows, it can be found in
`%USERPROFILE%/.kube/config`

This config is viewable without having to view the file directly.

**Command**
```
$ kubectl config view
```

**Example**
```yaml
❯ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://127.0.0.1:46347
  name: kind-kind
contexts:
- context:
    cluster: kind-kind
    user: kind-kind
  name: kind-kind
current-context: kind-kind
kind: Config
preferences: {}
users:
- name: kind-kind
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED

```

---

### `kubectl config`

Managing all aspects of contexts is done via the `kubectl config` command. Some examples include:
* See the active context with `kubectl config current-context`.
* Get a list of available contexts with `kubectl config get-contexts`.
* Switch to using another context with the `kubectl config use-context <context-name>` command.
* Add a new context with `kubectl config set-context <context name> --cluster=<cluster name> --user=<user> --namespace=<namespace>`.

There can be quite a few specifics involved when adding a context, for the available options, please see the
[Configuring Multiple Clusters](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/)
Kubernetes documentation.

---

### Exercise: Using Contexts
**Objective:** Create a new context called `kind-dev` and switch to it.

---

1. View the current contexts.
```
$ kubectl config get-contexts
```

2. Create a new context called `kind-dev` within the `kind-kind` cluster with the `dev` namespace, as the
`kind-kind` user.
```
$ kubectl config set-context kind-dev --cluster=kind-kind --user=kind-kind --namespace=dev
```

3. View the newly added context.
```
kubectl config get-contexts
```

4. Switch to the `kind-dev` context using `use-context`.
```
$ kubectl config use-context kind-dev
```

5. View the current active context.
```
$ kubectl config current-context
```

---

**Summary:** Understanding and being able to switch between contexts is a base fundamental skill required by every
Kubernetes user. As more clusters and namespaces are added, this can become unwieldy. Installing a helper
application such as [kubectx](https://github.com/ahmetb/kubectx) can be quite helpful. Kubectx allows a user to quickly
switch between contexts and namespaces without having to use the full `kubectl config use-context` command.

---
