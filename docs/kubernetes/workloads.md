# Kubernetes Workloads

## Overview

Kubernetes workloads are the objects that run your containerized applications. There are several different types of workloads, each with their own use cases and configuration options. This lesson will cover the following workload types:

* [Pods](https://kubernetes.io/docs/concepts/workloads/pods/)
* [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
* [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)
* [DaemonSets](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)
* [Jobs](https://kubernetes.io/docs/concepts/workloads/controllers/job/)
* [CronJobs](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)
* [ReplicaSets](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/)
* [Horizontal Pod Autoscalers](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
* [PodDisruptionBudgets](https://kubernetes.io/docs/tasks/run-application/configure-pdb/)

## Objectives

* Understand the different types of Kubernetes workloads
* Understand the use cases for each workload type
* Understand the configuration options for each workload type

## Outline

1. ReplicaSets

ReplicaSets are the primary method of managing Pod replicas and their lifecycle. This includes their scheduling, scaling, and deletion.

Their job is simple, always ensure the desired number of replicas that match the selector are running.

**manifests/replicaset.yaml**
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: example-rs
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
      env: prod
  template:
    metadata:
      labels:
        app: nginx
        env: prod
    spec:
      containers:
      - name: nginx
        image: nginx:stable-alpine
        ports:
        - containerPort: 80
```

**Command**
```
$ kubectl create -f manifests/rs-example.yaml
```

Watch the ReplicaSet's Pods come up:
```
$ kubectl get pods -l app=nginx,env=prod --watch
```

Scale the ReplicaSet:
```
$ kubectl scale replicaset example-rs --replicas=5
```

Create an independent Pod manually with the same labels as the one targeted by rs-example from the manifest manifests/pod-rs-example.yaml

**manifests/pod-rs-example.yaml**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-example
  labels:
    app: nginx
    env: prod
spec:
  containers:
  - name: nginx
    image: nginx:stable-alpine
    ports:
    - containerPort: 80
```

**Command**
```
kubectl create -f manifests/pod-rs-example.yaml
```



