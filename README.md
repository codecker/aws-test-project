# aws-test-project

Limited scope test project to meet the following requirements:

1. The template must deploy all resources required. Assume this will be deployed in a brand new account.
1. Network traffic logs must be enabled
1. Must use a server. Cannot use S3 (though this would be a great use case for it ☺)
1. The server cannot be in a public subnet
1. You must deploy the webserver through the template. NO MANUAL STEPS!
1. The web server can only be access from a single public IP address (55.55.55.55)

TODO:

1. Create KMS encryption keys
   1. S3 buckets
   1. EBS volumes
1. Create logging bucket
   1. Enable Encryption
   1. Enable Versioning
   1. Enforce MFA delete restriction
   1. Create lifecycle policy
   1. Restrict public access
1. Create VPC in US-EAST-1
   1. Create 2 public subnets and 2 private subnets
   1. Create route tables
   1. Create Network ACL
   1. Enable VPC Flow Logs
1. Create AWS Launch Template
   1. Use AmazonLinux2 image
   1. Download
   1. Create bootstrap script to deploy website
1. Create EC2 Autoscaling group
   1. Use Spot instances
   1. Spread across private subnets
   1. Create autoscaling policy
1. Create Application Load Balancer
   1. Use Autoscaling Group as source
1. Create Cloudfront distribution
   1. Add Web ACL to allow only 55.55.55.55
   1. Allow HTTPS only, redirect HTTP
