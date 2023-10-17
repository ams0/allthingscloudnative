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

# Deployments
Deployments are a declarative method of managing Pods via ReplicaSets. They provide rollback functionality in addition
to more granular update control mechanisms.

---

### Exercise: Using Deployments
**Objective:** Create, update and scale a Deployment as well as explore the relationship of Deployment, ReplicaSet
and Pod.

---

1) Create a Deployment `deploy-example`. Configure it using the example yaml block below or use the manifest 
`manifests/deploy-example.yaml`. Additionally pass the `--record` flag to `kubectl` when you create the Deployment. 
The `--record` flag saves the command as an annotation, and it can be thought of similar to a git commit message.

**manifests/deployment-example.yaml**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: deploy-example
spec:
  replicas: 3
  revisionHistoryLimit: 3
  selector:
    matchLabels:
      app: nginx
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:stable-alpine
        ports:
        - containerPort: 80
```

**Command**
```
$ kubectl create -f manifests/deploy-example.yaml --record
```

2) Check the status of the Deployment.
```
$ kubectl get deployments
```

3) Once the Deployment is ready, view the current ReplicaSets and be sure to show the labels.
```
$ kubectl get rs --show-labels
```
Note the name and `pod-template-hash` label of the newly created ReplicaSet. The created ReplicaSet's name will
include the `pod-template-hash`.

4) Describe the generated ReplicaSet.
```
$ kubectl describe rs deploy-example-<pod-template-hash>
```
Look at both the `Labels` and the `Selectors` fields. The `pod-template-hash` value has automatically been added to
both the Labels and Selector of the ReplicaSet. Then take note of the `Controlled By` field. This will reference the
direct parent object, and in this case the original `deploy-example` Deployment.

5) Now, get the Pods and pass the `--show-labels` flag.
```
$ kubectl get pods --show-labels
```
Just as with the ReplicaSet, the Pods name are labels include the `pod-template-hash`.

6) Describe one of the Pods.
```
$ kubectl describe pod deploy-example-<pod-template-hash-<random>
```
Look at the `Controlled By` field. It will contain a reference to the parent ReplicaSet, but not the parent Deployment.

Now that the relationship from Deployment to ReplicaSet to Pod is understood. It is time to update the
`deploy-example` and see an update in action.

7) Update the `deploy-example` manifest and add a few additional labels to the Pod template. Once done, apply the
change with the `--record` flag.
```
$ kubectl apply -f manifests/deploy-example.yaml --record
  < or >
$ kubectl edit deploy deploy-example --record
```
**Tip:** `deploy` can be substituted for `deployment` when using `kubectl`.

8) Immediately watch the Pods.
```
$ kubectl get pods --show-labels --watch
```
The old version of the Pods will be phased out one at a time and instances of the new version will take its place.
The way in which this is controlled is through the `strategy` stanza. For specific documentation this feature, see
the [Deployment Strategy Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy).

9) Now view the ReplicaSets.
```
$ kubectl get rs --show-labels
```
There will now be two ReplicaSets, with the previous version of the Deployment being scaled down to 0.

10) Now, scale the Deployment up as you would a ReplicaSet, and set the `replicas=5`.
```
$ kubectl scale deploy deploy-example --replicas=5
```

11) List the ReplicaSets.
```
$ kubectl get rs --show-labels
```
Note that there is **NO** new ReplicaSet generated. Scaling actions do **NOT** trigger a change in the Pod Template.

12) Just as before, describe the Deployment, ReplicaSet and one of the Pods. Note the `Events` and `Controlled By`
fields. It should present a clear picture of relationship between objects during an update of a Deployment.
```
$ kubectl describe deploy deploy-example
$ kubectl describe rs deploy-example-<pod-template-hash>
$ kubectl describe pod deploy-example-<pod-template-hash-<random>
```

---

**Summary:** Deployments are the main method of managing applications deployed within Kubernetes. They create and
supervise targeted ReplicaSets by generating a unique hash called the `pod-template-hash` and attaching it to child
objects as a Label along with automatically including it in their Selector. This method of managing rollouts along with
being able to define the methods and tolerances in the update strategy permits for a safe and seamless way of updating
an application in place.

---

### Exercise: Rolling Back a Deployment
**Objective:** Learn how to view the history of a Deployment and rollback to older revisions.

**Note:** This exercise builds off the previous exercise: [Using Deployments](#exercise-using-deployments). If you
have not, complete it first before continuing.

---

1) Use the `rollout` command to view the `history` of the Deployment `deploy-example`.
```
$ kubectl rollout history deployment deploy-example
```
There should be two revisions. One for when the Deployment was first created, and another when the additional Labels
were added. The number of revisions saved is based off of the `revisionHistoryLimit` attribute in the Deployment spec.

2) Look at the details of a specific revision by passing the `--revision=<revision number>` flag.
```
$ kubectl rollout history deployment deploy-example --revision=1
$ kubectl rollout history deployment deploy-example --revision=2
```
Viewing the specific revision will display a summary of the Pod Template.

3) Choose to go back to revision `1` by using the `rollout undo` command.
```
$ kubectl rollout undo deployment deploy-example --to-revision=1
```
**Tip:** The `--to-revision` flag can be omitted if you wish to just go back to the previous configuration.

4) Immediately watch the Pods.
```
$ kubectl get pods --show-labels --watch
```
They will cycle through rolling back to the previous revision.

5) Describe the Deployment `deploy-example`.
```
$ kubectl describe deployment deploy-example
```
The events will describe the scaling back of the previous and switching over to the desired revision.

---

**Summary:** Understanding how to use `rollout` command to both get a diff of the different revisions as well as
be able to roll-back to a previously known good configuration is an important aspect of Deployments that cannot
be left out.

---

**Clean Up Command**
```
kubectl delete deploy deploy-example
```

---

[Back to Index](#index)

---
---

# DaemonSets

DaemonSets ensure that all nodes matching certain criteria will run an instance of the supplied Pod.

They bypass default scheduling mechanisms and restrictions, and are ideal for cluster wide services such as
log forwarding, or health monitoring.

---

### Exercise: Managing DaemonSets
**Objective:** Experience creating, updating, and rolling back a DaemonSet. Additionally delve into the process of
how they are scheduled and how an update occurs.

---

1) Create DaemonSet `ds-example` and pass the `--record` flag. Use the example yaml block below as a base, or use
the manifest `manifests/ds-example.yaml` directly.

**manifests/ds-example.yaml**
```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: ds-example
spec:
  revisionHistoryLimit: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      nodeSelector:
        nodeType: edge
      containers:
      - name: nginx
        image: nginx:stable-alpine
        ports:
        - containerPort: 80
```

**Command**
```
$ kubectl create -f manifests/ds-example.yaml --record
```

2) View the current DaemonSets.
```
$ kubectl get daemonset
```
As there are no matching nodes, no Pods should be scheduled.

3) Label the `kind-control-plane` node with `nodeType=edge`
```
$ kubectl label node kind-control-plane nodeType=edge
```

4) View the current DaemonSets once again.
```
$ kubectl get daemonsets
```
There should now be a single instance of the DaemonSet `ds-example` deployed.

5) View the current Pods and display their labels with `--show-labels`.
```
$ kubectl get pods --show-labels
```
Note that the deployed Pod has a `controller-revision-hash` label. This is used like the `pod-template-hash` in a
Deployment to track and allow for rollback functionality.

6) Describing the DaemonSet will provide you with status information regarding it's Deployment cluster wide.
```
$ kubectl describe ds ds-example
```
**Tip:** `ds` can be substituted for `daemonset` when using `kubectl`.

7) Update the DaemonSet by adding a few additional labels to the Pod Template and use the `--record` flag.
```
$ kubectl apply -f manifests/ds-example.yaml --record
  < or >
$ kubectl edit ds ds-example --record
```

8) Watch the Pods and be sure to show the labels.
```
$ kubectl get pods --show-labels --watch
```
The old version of the DaemonSet will be phased out one at a time and instances of the new version will take its
place. Similar to Deployments, DaemonSets have their own equivalent to a Deployment's `strategy` in the form of
`updateStrategy`. The defaults are generally suitable, but other tuning options may be set. For reference, see the
[Updating DaemonSet Documentation](https://kubernetes.io/docs/tasks/manage-daemon/update-daemon-set/#performing-a-rolling-update).

---

**Summary:** DaemonSets are usually used for important cluster-wide support services such as Pod Networking, Logging,
or Monitoring. They differ from other workloads in that their scheduling bypasses normal mechanisms, and is centered
around node placement. Like Deployments, they have their own `pod-template-hash` in the form of
`controller-revision-hash` used for keeping track of Pod Template revisions and enabling rollback functionality.

---

### Optional: Working with DaemonSet Revisions

**Objective:** Explore using the `rollout` command to rollback to a specific version of a DaemonSet.

**Note:** This exercise is functionally identical to the Exercise[Rolling Back a Deployment](#exercise-rolling-back-deployment).
If you have completed that exercise, then this may be considered optional. Additionally, this exercise builds off
the previous exercise [Managing DaemonSets](#exercise-managing-daemonsets) and it must be completed before continuing.

---

1) Use the `rollout` command to view the `history` of the DaemonSet `ds-example`
```
$ kubectl rollout history ds ds-example
```
There should be two revisions. One for when the Deployment was first created, and another when the additional Labels
were added. The number of revisions saved is based off of the `revisionHistoryLimit` attribute in the DaemonSet spec.

2) Look at the details of a specific revision by passing the `--revision=<revision number>` flag.
```
$ kubectl rollout history ds ds-example --revision=1
$ kubectl rollout history ds ds-example --revision=2
```
Viewing the specific revision will display the Pod Template.

3) Choose to go back to revision `1` by using the `rollout undo` command.
```
$ kubectl rollout undo ds ds-example --to-revision=1
```
**Tip:** The `--to-revision` flag can be omitted if you wish to just go back to the previous configuration.

4) Immediately watch the Pods.
```
$ kubectl get pods --show-labels --watch
```
They will cycle through rolling back to the previous revision.

5) Describe the DaemonSet `ds-example`.
```
$ kubectl describe ds ds-example
```
The events will be sparse with a single host, however in an actual Deployment they will describe the status of
updating the DaemonSet cluster wide, cycling through hosts one-by-one.

---

**Summary:** Being able to use the `rollout` command with DaemonSets is import in scenarios where one may have
to quickly go back to a previously known-good version. This becomes even more important for 'infrastructure' like
services such as Pod Networking.

---

**Clean Up Command**
```
kubectl delete ds ds-example
```

---

[Back to Index](#index)

---
---

