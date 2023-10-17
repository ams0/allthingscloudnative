# Node management

## Outcomes

- Understand the role of a node in a Kubernetes cluster
- Understand how to add and remove nodes from a cluster
- Understand how to configure nodes
- Understand how to manage nodes
- Cordon and uncordon nodes
- Drain nodes

## Outline

A node is a physical or virtual machine on which pods and other resources that underpin your workload run. Each node is managed by a master node known as a control pane which contains multiple services required to run pods. A cluster typically has multiple nodes.

To get the number of nodes on your cluster, run:

```bash
$ kubectl get nodes
List Nodes in Kubernetes Cluster
List Nodes in Kubernetes Cluster
To get the pods running on a node, execute:
```

```bash
$ kubectl get pods -o wide | grep <node_name>
List Pods Running on Kubernetes Cluster
List Pods Running on Kubernetes Cluster
To mark your node as unschedulable, run.

$ kubectl cordon minikube

node/minikube cordoned
To mark your node as schedulable, run.
```

```bash
$ kubectl uncordon minikube

node/minikube uncordoned
To display resource usage metrics such as RAM and CPU run:
$ kubectl top node <node_name>
To delete a node or multiple nodes, run the command:

$ kubectl delete node <node_name>
```