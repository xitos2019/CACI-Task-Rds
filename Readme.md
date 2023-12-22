# Getting Started
This document will provide steps to create RDS instance for Mysql and underlaying resources using terraform script.
clone [repository](https://github.com/xitos2019/CACI-Task-Rds) which contains terraform script to create below resources. 

* MySql Rds Instance
* VPC (subnet for db and subnet for app)
* Security group for VPV

> Before applying below script please add db password in `dev.tfvars` file

Run below command to fire up RDS Instance

`terraform apply -var-file dev.tfvars`

**Summery**

* I have spin up MySql RDS keeping in mind this should be highly available i have enable multiAz deployment which enables automatic failover incase of unplanned outage or DB instance failure etc. in MultiAz DNS endpoints remains same during failvoer.
  

* To Serve the traffic from EC2 instances i have created db instance in same VPC where EC2 instances will be created making sure EC2 instances should allowed to talk to DB instance.

* I have also allowed traffic on security group for inbound and attached that security group with DB instance

* We scale up and down the instance as per our requirements as i have enabled performance insight which we can integrate with cloud watch to setup alarms and notifications based on specific performance thresholds.


**Improvements Suggestions**

* To make this exercise better we can use terraform modules to create RDS instance or any other resources also we can store `state file` on S3 storage or terraform cloud.
* We can utilize AWS secret manager to store database user name and password and call them into our terrafrom code with `Data source`
* I have chosen Mysql RDS service as in task requirement was to create RDS service AWS i would preffer to go with Amazon Aurora as per business requirements because Aurora can give you auto scaling and managed by AWS but Amazon Aurora cost is 20% more than Mysql RDS.
*  I have created terraform for Aurora cluster as well i would opt for Amazon Aurora as this will give me autoscaling i can set scaling limit for db instances because of task requirement i have comment out terraform code for Aurora.


