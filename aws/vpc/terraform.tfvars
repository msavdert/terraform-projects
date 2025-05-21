namespace      = "melih"
region         = "us-east-1"
environment    = "dev"
vpc_cidr       = "20.0.0.0/16"
azs            = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnets = ["20.0.1.0/24", "20.0.2.0/24", "20.0.3.0/24"]
public_subnets  = ["20.0.101.0/24", "20.0.102.0/24", "20.0.103.0/24"]

enable_nat_gateway = false
single_nat_gateway = false
one_nat_gateway_per_az = false
enable_internet_gateway = true

# Tags for all resources
tags = {
  Project     = "Demo-Project"
  Environment = "Development"
  Owner       = "Melih Savdert"
  ManagedBy   = "Terraform"
}
