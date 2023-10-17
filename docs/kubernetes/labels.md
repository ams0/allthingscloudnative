# Labels and Selectors

## Labels and Selectors
Labels are key-value pairs that are used to identify, describe and group together related sets of objects or
resources.

Selectors use labels to filter or select objects, and are used throughout Kubernetes.

---

### Exercise: Using Labels and Selectors
**Objective:** Explore the methods of labeling objects in addition to filtering them with both equality and
set-based selectors.

---

1) Label the Pod `pod-example` with `app=nginx` and `environment=dev` via `kubectl`.

```
$ kubectl label pod pod-example app=nginx environment=dev
```

2) View the labels with `kubectl` by passing the `--show-labels` flag
```
$ kubectl get pods --show-labels
```

3) Update the multi-container example manifest created previously with the labels `app=nginx` and `environment=prod`
then apply it via `kubectl`.

**manifests/pod-multi-container-example.yaml**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: multi-container-example
  labels:
    app: nginx
    environment: prod
spec:
  containers:
  - name: nginx
    image: nginx:stable-alpine
    ports:
    - containerPort: 80
    volumeMounts:
    - name: html
      mountPath: /usr/share/nginx/html
  - name: content
    image: alpine:latest
    volumeMounts:
    - name: html
      mountPath: /html
    command: ["/bin/sh", "-c"]
    args:
      - while true; do
          date >> /html/index.html;
          sleep 5;
        done
  volumes:
  - name: html
    emptyDir: {}
```

**Command**
```
$ kubectl apply -f manifests/pod-multi-container-example.yaml
```

4) View the added labels with `kubectl` by passing the `--show-labels` flag once again.
```
$ kubectl get pods --show-labels
```

5) With the objects now labeled, use an [equality based selector](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#equality-based-requirement) 
targeting the `prod` environment.

```
$ kubectl get pods --selector environment=prod
```

6) Do the same targeting the `nginx` app with the short version of the selector flag (`-l`).
```
$ kubectl get pods -l app=nginx
```

7) Use a [set-based selector](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#set-based-requirement)
to view all pods where the `app` label is `nginx` and filter out any that are in the `prod` environment.

```
$ kubectl get pods -l 'app in (nginx), environment notin (prod)'
```

---

**Summary:** Kubernetes makes heavy use of labels and selectors in near every aspect of it. The usage of selectors
may seem limited from the cli, but the concept can be extended to when it is used with higher level resources and
objects.

