# Logging

## Outcomes

- Understand the importance of centralized logging in Kubernetes.
- Learn how to deploy the Elasticsearch, Fluentd, and Kibana (EFK) stack for logging.
- Understand how to collect logs from Kubernetes clusters and applications.
- Learn how to view and analyze logs using Kibana.
- Understand best practices for managing logs in Kubernetes.

## What is Logging in Kubernetes?

Logging is essential for understanding the behavior and performance of applications running in Kubernetes. In Kubernetes, each component and container generates logs that provide information about system performance, errors, and events. Centralized logging solutions, such as the **Elasticsearch, Fluentd, Kibana (EFK) stack**, help collect, store, and visualize logs across the entire Kubernetes cluster.

### Why Centralized Logging is Important:
- **Easier troubleshooting**: Centralized logs provide a single location to analyze logs from all components and containers.
- **Long-term storage**: Kubernetes pods are ephemeral, so logs must be stored outside the pod lifecycle.
- **Searchable and organized**: Tools like Elasticsearch allow fast, full-text search across logs.
- **Visual insights**: Kibana provides a graphical interface to analyze trends and patterns in logs.

## How to Set Up Centralized Logging with the EFK Stack

The **EFK stack** (Elasticsearch, Fluentd, and Kibana) is commonly used for centralized logging in Kubernetes. Each component plays a specific role:
- **Fluentd**: Collects and forwards logs to Elasticsearch.
- **Elasticsearch**: Stores and indexes logs for fast retrieval.
- **Kibana**: Provides a UI to visualize and search logs.

### Step 1: Deploying Elasticsearch

**Elasticsearch** stores logs collected by Fluentd. It’s a distributed, RESTful search engine that allows fast full-text searches.

To deploy Elasticsearch using Helm:

1. Add the Helm repository:
   ```bash
   helm repo add elastic https://helm.elastic.co
   ```

2. Install Elasticsearch:
   ```bash
   helm install elasticsearch elastic/elasticsearch
   ```

This will create an Elasticsearch cluster that is ready to receive logs from Fluentd.

### Step 2: Deploying Fluentd

**Fluentd** is responsible for collecting logs from Kubernetes pods and nodes, formatting them, and sending them to Elasticsearch.

To deploy Fluentd using Helm:

1. Add the Helm repository:
   ```bash
   helm repo add fluent https://fluent.github.io/helm-charts
   ```

2. Install Fluentd:
   ```bash
   helm install fluentd fluent/fluentd
   ```

By default, Fluentd will collect logs from all containers and nodes in your Kubernetes cluster and forward them to Elasticsearch.

### Step 3: Deploying Kibana

**Kibana** is a web UI that allows you to query and visualize the logs stored in Elasticsearch. It provides charts, graphs, and search capabilities that help in analyzing logs.

To deploy Kibana using Helm:

1. Install Kibana:
   ```bash
   helm install kibana elastic/kibana
   ```

2. Access Kibana via port forwarding:
   ```bash
   kubectl port-forward svc/kibana-kibana 5601:5601
   ```

Once deployed, Kibana will be accessible at `http://localhost:5601`, where you can visualize logs from your Kubernetes cluster.

## Collecting Logs from Kubernetes Pods

Fluentd collects logs from all pods by default in Kubernetes. If your application is logging to `stdout` or `stderr`, Fluentd automatically collects and forwards these logs to Elasticsearch. However, you can customize the logging behavior by defining `ConfigMaps` or using custom Fluentd filters.

### Example: Custom Fluentd ConfigMap

If you need to apply custom filtering or routing rules for logs, you can configure Fluentd with a `ConfigMap`. Below is an example of a custom Fluentd configuration:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: fluentd-config
  namespace: kube-system
data:
  fluent.conf: |
    <source>
      @type tail
      path /var/log/containers/*.log
      pos_file /var/log/fluentd-containers.log.pos
      tag kube.*
      format json
    </source>

    <filter kube.**>
      @type kubernetes_metadata
    </filter>

    <match kube.**>
      @type elasticsearch
      host elasticsearch.default.svc.cluster.local
      port 9200
      logstash_format true
    </match>
```

This configuration collects logs from all containers and forwards them to Elasticsearch with Kubernetes metadata, which is useful for querying logs based on namespaces, pod names, or labels.

## Viewing and Analyzing Logs in Kibana

Once logs are collected and indexed by Elasticsearch, Kibana provides powerful tools to search, filter, and visualize logs.

### Step 1: Creating an Index Pattern in Kibana

To start analyzing logs in Kibana, create an index pattern that matches the log indices stored in Elasticsearch:

1. Open Kibana and go to **Management > Index Patterns**.
2. Create a new index pattern that matches the log indices (e.g., `fluentd-*`).
3. Select a timestamp field (such as `@timestamp`) for filtering logs by time.

### Step 2: Searching Logs in Kibana

You can search logs in Kibana using its search bar. For example, to find logs for a specific pod:

```bash
kubernetes.pod_name: "my-app-pod"
```

You can also use the **Discover** tab to search for logs based on pod labels, namespaces, or log content.

### Step 3: Visualizing Logs with Kibana Dashboards

Kibana allows you to create dashboards that provide visual representations of logs over time. You can create visualizations such as:

- Log counts over time.
- Error trends across different services.
- Logs grouped by pod or namespace.

These dashboards help in identifying issues and trends quickly.

## Best Practices for Logging in Kubernetes

1. **Log to stdout/stderr**: Ensure that your applications log to `stdout` and `stderr` so that logs can be collected by Fluentd.
2. **Limit log verbosity**: Avoid excessive logging to reduce the volume of logs and ensure relevant information is captured.
3. **Retain logs appropriately**: Configure Elasticsearch for appropriate log retention policies to avoid excessive storage usage.
4. **Monitor log storage**: Ensure that Elasticsearch has enough resources for storing and indexing logs, especially in large clusters.
5. **Use custom filters**: Apply Fluentd filters to extract meaningful information from logs and discard unnecessary data.

## Summary

Centralized logging in Kubernetes is crucial for effective troubleshooting and monitoring. By deploying the **EFK stack** (Elasticsearch, Fluentd, Kibana), you can collect logs from all containers and nodes, store them efficiently, and visualize them through Kibana. This provides valuable insights into the behavior of your applications and helps identify and resolve issues quickly. Implementing best practices for logging will ensure that your Kubernetes environment remains performant and manageable.
