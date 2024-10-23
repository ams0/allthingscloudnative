# What happens when a pod is deleted

What happens behind the scene when a pod gets deleted?

When we do: 
```bash
$ kubectl delete pod nginx

pod "nginx" deleted
```

What actually happens behind the scenes?

Before continuing, let's remind ourselves of the [linux signals](https://man7.org/linux/man-pages/man7/signal.7.html) that are available to us from the container perspective:

**SIGTERM**: Requests a graceful shutdown, allowing the program to finish tasks and clean up. In Kubernetes, pods get time to exit cleanly.

**SIGKILL**: Forces an immediate stop, with no cleanup. If a pod doesn't shut down in time after SIGTERM, Kubernetes sends SIGKILL to terminate it **immediately**.

![
](deletion.png)

1. kubectl delete pod: Triggers the API Server to update ETCD with deletionTimestamp and deletionGracePeriodSeconds, marking the pod as Terminating.
2. API Server → Kubelet: Notifies the Kubelet of the pod’s termination.
3. Endpoint Controller: Removes the pod from active service endpoints, stopping any traffic from reaching the pod.
4. PreStop Hook (if configured): Before sending SIGTERM, the Kubelet runs the PreStop Hook. This allows the pod to perform custom tasks (e.g., closing connections) during shutdown.
5. SIGTERM: Kubelet sends SIGTERM, initiating a graceful shutdown. The pod is given the deletionGracePeriodSeconds (default 30s) to cleanly exit.
6. Graceful Shutdown: During the grace period, the pod handles any ongoing tasks, such as completing requests or saving data, before it fully stops.
7. SIGKILL: If the pod doesn't terminate within the grace period, SIGKILL is sent, forcing immediate shutdown.
8. Pod Deleted: The API Server updates ETCD, marking the pod as deleted. Components like Kube-Proxy, Ingress, and others remove all references to the pod.