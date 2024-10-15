# Pod Security Policies in Kubernetes

## Introduction

Pod Security Policies (PSPs) control sensitive aspects of pod specification to ensure secure operations. With PSPs, cluster administrators can define conditions that pods must meet, such as running as a non-root user, disallowing privileged containers, and limiting access to host resources.

## Best Practices for Pod Security

1. **Run containers as non-root**: Avoid running containers with root privileges to limit the attack surface.
2. **Disable privileged containers**: Privileged containers should be disabled unless explicitly required.
3. **Control capabilities**: Minimize the capabilities assigned to containers.
4. **Limit volume types**: Restrict the volume types to necessary ones, such as `ConfigMap` or `PersistentVolumeClaim`.
5. **Restrict host namespaces**: Avoid allowing access to host PID, network, and IPC namespaces.

## Example: Pod Security Policy

The following Pod Security Policy restricts running privileged containers and ensures pods run as non-root users:

```yaml
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: restricted
spec:
  privileged: false
  runAsUser:
    rule: MustRunAsNonRoot
  fsGroup:
    rule: RunAsAny
  volumes:
    - 'configMap'
    - 'emptyDir'
    - 'secret'
    - 'persistentVolumeClaim'
  seLinux:
    rule: RunAsAny
  supplementalGroups:
    rule: RunAsAny
```

## Enforcing Pod Security
To apply Pod Security Policies, create a Role or ClusterRole that grants access to use the PSP:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: mynamespace
  name: use-psp
rules:
- apiGroups: ["policy"]
  resources: ["podsecuritypolicies"]
  verbs: ["use"]
  resourceNames: ["restricted"]
```

Then, bind this role to a user or group using a RoleBinding or ClusterRoleBinding.

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: psp-rolebinding
  namespace: mynamespace
subjects:
- kind: User
  name: user1
roleRef:
  kind: Role
  name: use-psp
  apiGroup: rbac.authorization.k8s.io
```

!!! Deprecation Notice

PodSecurityPolicy is deprecated in Kubernetes 1.21 and will be removed in future releases. Alternatives like Open Policy Agent (OPA) or Pod Security Admission (PSA) are recommended for enforcing pod security in future versions of Kubernetes.
