# VPC Terraform Module

This project provisions an AWS VPC using the [terraform-aws-modules/vpc/aws](https://github.com/terraform-aws-modules/terraform-aws-vpc) module. All resource names are prefixed with the namespace variable, and all tags are managed via a single tags variable.

## Features
- Configurable VPC CIDR and region
- 3 public and 3 private subnets (customizable)
- NAT Gateway options (fully variable)
- All resource names prefixed with a namespace
- Simple, centralized tagging via the tags variable
- All settings are managed via variables

## Usage

```hcl
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.namespace}-vpc"
  cidr = var.vpc_cidr
  azs  = var.azs

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway      = var.enable_nat_gateway
  single_nat_gateway      = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az

  tags = var.tags

  vpc_tags = {
    Name = "${var.namespace}-vpc"
  }
  public_subnet_tags = {
    Name = "${var.namespace}-public"
  }
  private_subnet_tags = {
    Name = "${var.namespace}-private"
  }
}
```

## Variables
See `variables.tf` for all available variables and their descriptions.

## Example `terraform.tfvars`
```hcl
namespace         = "example"
region            = "us-east-1"
vpc_cidr          = "20.0.0.0/16"
azs               = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnets   = ["20.0.1.0/24", "20.0.2.0/24", "20.0.3.0/24"]
public_subnets    = ["20.0.101.0/24", "20.0.102.0/24", "20.0.103.0/24"]
enable_nat_gateway = true
single_nat_gateway = false
one_nat_gateway_per_az = false
tags = {
  Project     = "Demo-Project"
  Environment = "Development"
  Owner       = "Melih Savdert"
  ManagedBy   = "Terraform"
}
```

## Outputs
- `vpc_id`: The ID of the VPC
- `vpc_cidr_block`: The CIDR block of the VPC
- `private_subnets`: List of private subnet IDs
- `public_subnets`: List of public subnet IDs

## Requirements
- Terraform >= 1.0
- AWS provider >= 5.79

## License
MIT
