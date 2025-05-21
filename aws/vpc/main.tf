terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.79"
    }
  }
}

provider "aws" {
  region = var.region
}

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
  one_nat_gateway_per_az  = var.one_nat_gateway_per_az
  enable_internet_gateway = var.enable_internet_gateway

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
