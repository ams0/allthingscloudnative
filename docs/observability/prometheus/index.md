# Prometheus

## Outcomes

- Understand what Prometheus is.
- Learn how to deploy Prometheus in a Kubernetes cluster.
- Understand how to scrape metrics from Kubernetes components and applications.
- Learn how to set up alerting with Prometheus Alertmanager.
- Understand how to integrate Prometheus with Grafana for visualization.

## What is Prometheus?

Prometheus is an open-source monitoring and alerting toolkit designed specifically for reliability and scalability. It collects metrics from your applications, services, and systems, stores them in a time-series database, and provides a powerful query language (PromQL) for analyzing and visualizing the metrics.

Prometheus is widely used in Kubernetes environments for monitoring because it can natively scrape metrics from Kubernetes components like kubelet, kube-apiserver, and user-defined applications.

### Key Benefits of Prometheus:
- **Efficient metrics collection**: Scrapes metrics from any HTTP endpoint that exposes them.
- **Time-series database**: Stores metrics efficiently for historical analysis.
- **Alerting**: Supports threshold-based alerting using Prometheus Alertmanager.
- **Flexible querying**: PromQL allows flexible, precise queries to analyze metrics.
- **Scalability**: Prometheus is horizontally scalable by using a federation model for large environments.

## How to Deploy Prometheus in Kubernetes

### Step 1: Deploy Prometheus using Helm

You can deploy Prometheus using the Helm chart, which simplifies installation and configuration in a Kubernetes environment.

1. Add the stable Helm chart repository:
   ```bash
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
   ```

2. Install Prometheus with Helm:
   ```bash
   helm install prometheus prometheus-community/prometheus
   ```

This will install Prometheus with a default configuration in your Kubernetes cluster.

### Step 2: Accessing Prometheus

To access Prometheus, you can forward the Prometheus server port to your local machine:

```bash
kubectl port-forward deploy/prometheus-server 9090
```

Once the port forwarding is active, you can open `http://localhost:9090` in your browser to access the Prometheus UI.

## Scraping Metrics from Kubernetes

Prometheus is often used to scrape metrics from Kubernetes components such as kubelet, kube-apiserver, and cAdvisor. Kubernetes exposes these metrics through its built-in `/metrics` endpoints.

### Example: Scraping kube-apiserver Metrics

To scrape metrics from the Kubernetes API server, you need to add a scrape configuration to the Prometheus configuration file (`prometheus.yml`):

```yaml
scrape_configs:
  - job_name: 'kube-apiserver'
    static_configs:
      - targets: ['kube-apiserver.default.svc.cluster.local:443']
    scheme: https
```

Prometheus will scrape the kube-apiserver’s `/metrics` endpoint for metrics on service requests, API usage, and latency.

## Monitoring Custom Applications

To monitor custom applications, ensure your application exposes metrics in a Prometheus-compatible format. This can be done with libraries such as **Prometheus client libraries** for different programming languages (e.g., Go, Java, Python, etc.).

### Example: Exposing Metrics in a Custom Application (Go)

```go
package main

import (
    "github.com/prometheus/client_golang/prometheus"
    "github.com/prometheus/client_golang/prometheus/promhttp"
    "net/http"
)

var requestCount = prometheus.NewCounter(
    prometheus.CounterOpts{
        Name: "http_requests_total",
        Help: "Number of HTTP requests processed.",
    },
)

func init() {
    prometheus.MustRegister(requestCount)
}

func handler(w http.ResponseWriter, r *http.Request) {
    requestCount.Inc()
    w.Write([]byte("Hello, Prometheus!"))
}

func main() {
    http.Handle("/metrics", promhttp.Handler())
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8080", nil)
}
```

After deploying this application, you can configure Prometheus to scrape metrics from the app by adding a new job in `prometheus.yml`:

```yaml
scrape_configs:
  - job_name: 'custom-app'
    static_configs:
      - targets: ['custom-app-service:8080']
```

## Setting Up Alerting with Prometheus Alertmanager

Prometheus is commonly used with **Alertmanager** to send alerts when metrics meet certain thresholds. Alertmanager can send notifications through various channels, such as email, Slack, PagerDuty, and more.

### Step 1: Deploy Alertmanager with Prometheus

If you installed Prometheus using Helm, Alertmanager should already be deployed. Otherwise, you can deploy it separately:

```bash
helm install alertmanager prometheus-community/alertmanager
```

### Step 2: Configure Alerts in Prometheus

You can define alerting rules in the Prometheus configuration file (`prometheus.yml`):

```yaml
groups:
- name: example-alerts
  rules:
  - alert: HighRequestLatency
    expr: http_request_duration_seconds{job="custom-app"} > 0.5
    for: 5m
    labels:
      severity: "warning"
    annotations:
      summary: "High request latency detected"
```

This rule triggers an alert if the request latency exceeds 0.5 seconds for more than 5 minutes.

### Step 3: Sending Alerts to Alertmanager

Configure Prometheus to send alerts to Alertmanager:

```yaml
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      - 'alertmanager:9093'
```

Once this configuration is applied, any triggered alerts will be forwarded to Alertmanager, where they can be routed to specific notification channels.

## Visualizing Prometheus Metrics with Grafana

Grafana is a powerful tool for visualizing metrics collected by Prometheus. You can easily create dashboards and monitor your Kubernetes cluster and applications.

### Step 1: Add Prometheus as a Data Source in Grafana

1. Access Grafana using port-forwarding or a load balancer.
   ```bash
   kubectl port-forward deploy/grafana 3000
   ```

2. Open `http://localhost:3000` and log into the Grafana UI.
3. Navigate to **Configuration > Data Sources** and add Prometheus as a new data source. Set the URL to the Prometheus service (e.g., `http://prometheus-server`).

### Step 2: Create Dashboards

Once Prometheus is added as a data source, you can create dashboards using PromQL queries to monitor different aspects of your Kubernetes environment or applications.

## Best Practices for Using Prometheus

1. **Scrape frequently used metrics**: Focus on essential metrics like CPU, memory, disk usage, and network traffic.
2. **Set up efficient alerting**: Use Alertmanager to route important alerts to the appropriate team, ensuring a timely response to critical issues.
3. **Use dashboards for monitoring**: Integrate Prometheus with Grafana to visualize and analyze metrics in real-time.
4. **Scale Prometheus**: For larger environments, consider scaling Prometheus by using federation or sharding strategies.

## Summary

Prometheus is a powerful and flexible monitoring tool that is well-suited for Kubernetes environments. By collecting and analyzing metrics, setting up alerts, and integrating with Grafana, Prometheus helps ensure the reliability and performance of your cluster and applications. Prometheus’s scalability and ease of integration with other tools like Alertmanager and Grafana make it an essential tool in any Kubernetes monitoring stack.
```
