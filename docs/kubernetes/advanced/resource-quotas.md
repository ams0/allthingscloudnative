# Resource Quotas

## Outcomes

In this lab, you will learn how to:
- Create a Resource Quota
- View Resource Quota usage
- View Resource Quota status
- Delete a Resource Quota

## Outline

Create a Resource Quota:

```bash
kubectl create quota my-quota --hard=cpu=1,memory=1G,pods=2,services=2,replicationcontrollers=2,resourcequotas=1
```

