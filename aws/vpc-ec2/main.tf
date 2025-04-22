provider "aws" {
  region = var.region
  default_tags {
    tags = var.tags
  }
}

# VPC Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name                 = "${var.namespace}-${var.vpc_name}"
  cidr                 = var.vpc_cidr
  azs                  = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_nat_gateway   = var.enable_nat_gateway

  tags = {Name = "${var.namespace}-${var.vpc_name}"}
}

# Security Group Module
module "sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.namespace}-${var.security_group_name}"
  description = var.security_group_description
  vpc_id      = module.vpc.vpc_id

  # No default ingress rules
  ingress_cidr_blocks = []
  ingress_rules       = []

  ingress_with_cidr_blocks = [
    for rule in var.custom_ports : {
      from_port   = rule.from_port
      to_port     = rule.to_port
      protocol    = rule.protocol
      cidr_blocks = rule.cidr_blocks
      description = rule.description
    }
  ]
  egress_rules = ["all-all"]

  tags = {Name = "${var.namespace}-${var.security_group_name}"}
}

# Key Pair
resource "tls_private_key" "this" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "${var.namespace}-${var.key_name}"
  public_key = trimspace(tls_private_key.this.public_key_openssh)
  # public_key = "ssh-rsa AAAA...."
}

# Save private key to file
resource "local_file" "private_key" {
  content         = tls_private_key.this.private_key_pem
  filename        = "${path.root}/${var.key_name}"
  file_permission = "0600"  # Secure permissions for private key
}

# Save public key to file
resource "local_file" "public_key" {
  content         = tls_private_key.this.public_key_openssh
  filename        = "${path.root}/${var.key_name}.pub"
  file_permission = "0644"
}

# EC2 Instance
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 4.0"

  name          = "${var.namespace}-${var.instance_name}"
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.security_group_id]
  subnet_id     = element(module.vpc.public_subnets, 0)
  associate_public_ip_address = var.associate_public_ip_address
  root_block_device = var.root_block_device
#  ephemeral_block_device = var.ephemeral_block_device
  # user_data = file("${path.module}/user_data.sh") # Optional user data script

  tags = {Name = "${var.namespace}-${var.instance_name}"}
}
