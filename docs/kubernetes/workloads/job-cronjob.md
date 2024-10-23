# Jobs and CronJobs

## Jobs

Working with Jobs is a bit different than working with Deployments. Create a Job using the following template:

```bash
kubectl apply -f - <<EOF
apiVersion: batch/v1
kind: Job
metadata:
  name: sleepy
spec:
  template:
    spec:
      containers:
      - name: resting
        image: busybox
        command: ["/bin/sleep"] 
        args: ["3"]
      restartPolicy: Never
EOF
job.batch/sleepy created
```

Check the Job

```bash
kubectl get job
NAME COMPLETIONS DURATION AGE
sleepy 0/1         3s     3s

kubectl describe jobs.batch sleepy
Name:             sleepy
Namespace:        default
Selector:         batch.kubernetes.io/controller-uid=97bb2f4b-b7de-4a8a-bc9a-180ad55d4a84
Labels:           batch.kubernetes.io/controller-uid=97bb2f4b-b7de-4a8a-bc9a-180ad55d4a84
                  batch.kubernetes.io/job-name=sleepy
                  controller-uid=97bb2f4b-b7de-4a8a-bc9a-180ad55d4a84
                  job-name=sleepy
Annotations:      <none>
Parallelism:      1
Completions:      1
Completion Mode:  NonIndexed
Suspend:          false
Backoff Limit:    6
Start Time:       Thu, 24 Oct 2024 00:41:56 +0200
Completed At:     Thu, 24 Oct 2024 00:42:06 +0200
Duration:         10s
Pods Statuses:    0 Active (0 Ready) / 1 Succeeded / 0 Failed
```

Play around with `parallelism`, `activeDeadlineSeconds` (change the sleep parameter too) and `completions` number (delete the job in between retries), how does that affect the number of concurrent pods running? 


## CronJobs

Create the CronJob:

```bash
kubectl apply -f - <<EOF
apiVersion: batch/v1
kind: CronJob
metadata:
  name: sleepy
spec:
  schedule: "*/2 * * * *" #<-- Add Linux style cronjob syntax
  jobTemplate: #<-- New jobTemplate and spec move
    spec:
      template: #<-- This and following lines move
        spec: #<-- four spaces to the right
          containers:
          - name: resting
            image: busybox
            command: ["/bin/sleep"]
            args: ["5"]
          restartPolicy: Never
EOF
```

Check the execution:

```bash
$ kubectl get cronjobs
NAME     SCHEDULE      TIMEZONE   SUSPEND   ACTIVE   LAST SCHEDULE   AGE
sleepy   */2 * * * *   <none>     False     0        <none>          11s

$ kubectl get jobs
NAME     STATUS     COMPLETIONS   DURATION   AGE
sleepy   Complete   1/1           10s        9m44s
```