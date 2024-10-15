# Helm

## Resources

[Helm Playground](https://helm-playground.com/)

## Outcomes

- Understand what Helm is and its role in Kubernetes.
- Learn how to install and configure Helm in a Kubernetes environment.
- Understand how to use Helm charts to deploy applications.
- Learn how to create and manage custom Helm charts.
- Understand how to use Helm for application upgrades and rollbacks.

## What is Helm?

Helm is a package manager for Kubernetes that simplifies the process of deploying, managing, and upgrading Kubernetes applications. Helm uses **charts**, which are pre-configured Kubernetes resource templates, to define the configuration and deployment of an application or service.

### Key Benefits of Helm:
- **Simplified deployments**: Helm automates the deployment of Kubernetes applications by using pre-configured templates.
- **Version control**: Helm allows versioning of charts and rollback capabilities in case of failures.
- **Reuse**: Helm charts can be reused across different environments such as development, staging, and production.
- **Customization**: Charts can be customized using values, allowing flexibility without modifying the core chart.

## How to Install Helm

To use Helm in your Kubernetes cluster, you first need to install Helm on your local machine and configure it to interact with your Kubernetes cluster.

### Step 1: Install Helm CLI

The Helm client can be installed using the following commands depending on your operating system:

- **macOS**:
  ```bash
  brew install helm
  ```

- **Linux**:
  ```bash
  curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
  ```

- **Windows**:
  Download the latest release from the [Helm GitHub releases](https://github.com/helm/helm/releases) page.

### Step 2: Configure Helm

Once Helm is installed, configure it to use your Kubernetes cluster by ensuring that `kubectl` is configured and connected to your cluster. Helm interacts with the Kubernetes API server using `kubectl`.

### Step 3: Adding a Helm Repository

Helm uses repositories to store and distribute charts. To add the official Helm stable repository, use the following command:

```bash
helm repo add stable https://charts.helm.sh/stable
```

To list all available repositories:

```bash
helm repo list
```

## Using Helm Charts to Deploy Applications

Helm charts define the structure of a Kubernetes application. A chart contains templates for Kubernetes resources, including deployments, services, and config maps.

### Step 1: Searching for a Chart

Helm allows you to search for charts in a repository. For example, to search for `nginx` charts in the stable repository:

```bash
helm search repo nginx
```

### Step 2: Installing a Helm Chart

To deploy an application using Helm, you can use the `helm install` command. For example, to install an `nginx` server:

```bash
helm install my-nginx stable/nginx
```

This command will deploy the `nginx` chart, and Helm will create the necessary Kubernetes resources based on the chart's configuration.

### Step 3: Viewing the Deployed Application

You can view the status of the deployed application using the `helm status` command:

```bash
helm status my-nginx
```

To see all installed Helm releases:

```bash
helm list
```

## Customizing Helm Charts

Helm allows you to customize the deployment of applications by passing a `values.yaml` file or using the `--set` flag during installation. 

### Example: Customizing a Deployment

You can pass custom values when installing a chart using the `--set` option. For example, to customize the `replicaCount` value for an `nginx` deployment:

```bash
helm install my-nginx stable/nginx --set replicaCount=3
```

Alternatively, you can create a `values.yaml` file with your custom values:

```yaml
replicaCount: 3
```

Then, install the chart with the values file:

```bash
helm install my-nginx stable/nginx -f values.yaml
```

## Creating Custom Helm Charts

In addition to using pre-existing charts, Helm allows you to create custom charts for your own applications.

### Step 1: Create a New Helm Chart

You can create a new Helm chart using the following command:

```bash
helm create my-chart
```

This command generates a directory structure for your new chart, which includes:
- `templates/`: Contains the Kubernetes manifest templates.
- `values.yaml`: Default configuration values.
- `Chart.yaml`: Metadata about the chart (name, version, etc.).

### Step 2: Editing the Chart

You can modify the default chart to fit your application. For example, you can edit the deployment template in the `templates/deployment.yaml` file.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "my-chart.fullname" . }}
spec:
  replicas: {{ .Values.replicaCount }}
  template:
    metadata:
      labels:
        app: {{ include "my-chart.name" . }}
    spec:
      containers:
      - name: {{ .Chart.Name }}
        image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
        ports:
        - containerPort: 80
```

### Step 3: Deploying the Custom Chart

Once your custom chart is ready, you can deploy it using Helm:

```bash
helm install my-app ./my-chart
```

Helm will render the templates with the provided values and create the Kubernetes resources.

## Helm Chart Upgrades and Rollbacks

Helm simplifies application management by allowing seamless upgrades and rollbacks.

### Step 1: Upgrading a Helm Release

To upgrade an existing Helm release with new values or a newer version of the chart:

```bash
helm upgrade my-nginx stable/nginx --set replicaCount=5
```

Helm will apply the changes to the Kubernetes resources without downtime.

### Step 2: Rolling Back a Helm Release

If something goes wrong after an upgrade, Helm allows you to roll back to a previous version:

```bash
helm rollback my-nginx 1
```

This command will roll back the release `my-nginx` to revision 1.

## Best Practices for Using Helm

1. **Version your charts**: Always version your custom charts to track changes over time.
2. **Test charts locally**: Use the `helm template` command to render templates locally and check for errors before deploying.
3. **Use values.yaml for configuration**: Store custom values in a `values.yaml` file instead of using the `--set` flag to keep deployments consistent.
4. **Automate with CI/CD**: Use Helm in your CI/CD pipeline to automate deployments and manage upgrades in a consistent and repeatable way.
5. **Secure Helm**: Helm 3 removed Tiller, improving security, but ensure your Helm charts and deployments follow best security practices, such as least privilege and encryption for sensitive data.

## Summary

Helm simplifies Kubernetes application management by packaging, deploying, and upgrading applications using charts. With Helm, you can easily deploy complex applications, manage configuration through `values.yaml` files, and handle versioning and rollbacks. By using Helm, Kubernetes users can streamline their deployment processes, improve application scalability, and automate infrastructure management.
```
