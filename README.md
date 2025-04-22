# Terraform AWS Infrastructure Projects

This repository contains Terraform configuration files for deploying various AWS infrastructure components.

## Projects

### VPC and EC2 Instance

Located in the `aws/vpc-ec2` directory, this project sets up:

- A VPC with public and private subnets
- EC2 instances with appropriate security groups
- Associated networking components

### RDS and S3 Resources

Located in the `aws/rds-s3` directory, this project provisions:

- RDS database instances
- S3 buckets for storage
- Required IAM permissions and policies

## Usage

Each project directory contains:

- `main.tf` - Main Terraform configuration file
- `variables.tf` - Variable definitions
- `terraform.tfvars` - Variable values
- `outputs.tf` - Output values

To deploy a project:

```bash
cd aws/<project-directory>
terraform init
terraform plan
terraform apply
```

## Prerequisites

- Terraform installed (version 1.0.0 or later)
- AWS CLI configured with appropriate credentials
- Proper IAM permissions to create resources

## License

This project is licensed under the MIT License - see the LICENSE file for details.
