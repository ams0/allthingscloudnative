# Role-Based Access Control (RBAC)

RBAC restricts access to resources based on the roles of individual users within your organization. Kubernetes uses RBAC to define which users or applications can perform specific operations on a cluster.

## Example: RBAC for Namespaces

The following example configures a `RoleBinding` that grants `read-only` access to resources in the `development` namespace:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: development
  name: dev-read-only
rules:
- apiGroups: [""]
  resources: ["pods", "services", "endpoints"]
  verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-only-binding
  namespace: development
subjects:
- kind: User
  name: dev-user
roleRef:
  kind: Role
  name: dev-read-only
  apiGroup: rbac.authorization.k8s.io
```
