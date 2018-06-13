# How to

![infra autoscaling-group](../img/05-autoscaling-group.png "infra autoscaling-group")

### Create stack

```
terraform apply
```

This script will create:
-   2 network
-   6 firewall rules
-   2 instance group
-   1 autoscaling group
-   2 loadbalancer

### Delete stack

```
terraform destroy
```
