region = "us-east-1"
namespace = "example"

# Tags for all resources
tags = {
  Project     = "Demo-Project"
  Environment = "Development"
  Owner       = "Melih Savdert"
  ManagedBy   = "Terraform"
}

# VPC variables
vpc_name           = "vpc"
vpc_cidr           = "10.0.0.0/16"
private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
enable_nat_gateway = false

# Security group variables
security_group_name        = "app-sg"
security_group_description = "Security group for the application"

# Custom ports - add any additional ports you need here
custom_ports = [ {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
    description = "HTTP access for anywhere"},
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "47.18.6.117/32"
    description = "SSH access from specific IP"}
]

# Key pair variables
key_name = "my-key-pair"

# EC2 instance variables
instance_name = "my-instance"
instance_type = "t2.micro"
ami_id        = "ami-0e449927258d45bc4" # Amazon Linux 2023
associate_public_ip_address = true
root_block_device = [ 
  {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
    encrypted             = false
  }
]