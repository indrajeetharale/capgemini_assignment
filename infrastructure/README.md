# Introducution
This `infrastructure` folder contains terraform code to create a CICD pipeline and deployment infrastructure for the associated spring boot and react application.

# Deployment Steps
1. Create backend infra to store terraform state
```bash
cd tf-backend
terraform init
terrform plan
terraform apply
cd ..
```

2. Copy output generated in step in a file named - **backend-config.hcl** and place the file in infrastructure directory. Make sure
to have values in double quotes in the file content as shown below

```bash
cat backend-config.hcl

bucket = "spring-boot-react-example-state-bucket-<YOUR_REGION>"
dynamodb_table = "spring-boot-react-example-state-table-<YOUR_REGION>"
key = "remote-state"
region = "<YOUR_REGION>"
```

5. Replace terraform.pub with a ssh public key that you can use to login to deployment EC2 machine.

4. Apply actual cicd + project infrastructure. Be sure to be in infrastructure directory.
```bash
terraform init --backend-config=backend-config.hcl
terraform plan
terraform apply
```
Supply needed variable values for - aws_region, path_to_public_key, your_ip_address

5. A codecommit repository will be created for you as part of terraform apply. Please add that as origin and push this codebase to that repository. Any changes on the repo and in the main branch
will be watched by AWS CodePipeline which in turn will trigger the CICD process.