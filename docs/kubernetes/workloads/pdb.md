# PodDisruptionBudget

Here’s a short lab to demonstrate the use of PodDisruptionBudget (PDB) in Kubernetes. This lab will guide you through creating a sample deployment and configuring a PDB to ensure that a minimum number of replicas remain available during disruptions.

Lab: Using PodDisruptionBudget in Kubernetes

Objective

Learn how to configure and use a PodDisruptionBudget to protect the availability of your pods during voluntary disruptions.

Prerequisites

	•	A running Kubernetes cluster
	•	kubectl configured to interact with your cluster

Step 1: Create a Sample Deployment

First, let’s create a sample deployment with 3 replicas of an nginx pod.

	1.	Create a file named nginx-deployment.yaml with the following content:

```bash
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
EOF
```

	2.	Apply the deployment file to your cluster:

```bash
kubectl apply -f nginx-deployment.yaml
```

	3.	Verify that the pods are running:

```bash
kubectl get pods -l app=nginx
```


Step 2: Define a PodDisruptionBudget (PDB)

Now that we have a deployment with 3 replicas, let’s create a PodDisruptionBudget to ensure at least 2 pods are available during disruptions.

	1.	Create a file named nginx-pdb.yaml with the following content:

```bash
kubectl apply -f - <<EOF
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: nginx-pdb
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app: nginx
EOF
```

	2.	Apply the PDB to your cluster:

kubectl apply -f nginx-pdb.yaml


	3.	Confirm that the PDB has been created:

kubectl get pdb



Step 3: Test the PodDisruptionBudget

Let’s test the PDB by attempting to drain a node where one or more of the nginx pods are running. The PDB should prevent the node drain if it would cause more than one pod to go unavailable.

	1.	Find a node where an nginx pod is running:

kubectl get pods -o wide -l app=nginx


	2.	Attempt to drain that node:

kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data

Since we have a PDB in place, Kubernetes will prevent the drain if it cannot maintain the minimum number of available replicas specified in the PDB.

	3.	After testing, you can uncordon the node:

kubectl uncordon <node-name>



Cleanup

To remove the resources created in this lab, use the following commands:

kubectl delete -f nginx-deployment.yaml
kubectl delete -f nginx-pdb.yaml

Summary

In this lab, we configured a PodDisruptionBudget for a deployment to ensure a minimum number of replicas remain available during node disruptions. This feature is particularly useful for applications that need to maintain high availability during maintenance operations.

This lab provides a basic understanding of how PDBs work and how they help in maintaining application uptime during voluntary disruptions.