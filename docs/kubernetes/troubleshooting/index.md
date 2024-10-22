# Kubernetes Troubleshooting

## Overview

This section will guide you thru common troubleshooting patterns.

## Cluster Events

One of the first step for troubleshooting should be to look at the event logs:

```bash
kubectl get events --all-namespaces
```

It's possible also to limit the output to a single namespace or resource. Logs for a resource are also available in the output of the `kubectl describe <resource>` command.


## Common scenarios

Some classic errors:

