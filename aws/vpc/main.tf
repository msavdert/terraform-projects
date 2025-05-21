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

locals {
  private_subnet_names = [
    for i, az in var.azs :
    "${var.namespace}-subnet-private${i + 1}-${az}"
  ]
  public_subnet_names = [
    for i, az in var.azs :
    "${var.namespace}-subnet-public${i + 1}-${az}"
  ]
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.namespace}-vpc"
  cidr = var.vpc_cidr
  azs  = var.azs

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  private_subnet_names = local.private_subnet_names
  public_subnet_names  = local.public_subnet_names

  enable_nat_gateway      = var.enable_nat_gateway
  single_nat_gateway      = var.single_nat_gateway
  one_nat_gateway_per_az  = var.one_nat_gateway_per_az
  create_igw              = var.create_igw

  tags = var.tags

  vpc_tags = {
    Name = "${var.namespace}-vpc"
  }
  igw_tags = {
    Name = "${var.namespace}-igw"
  }
}
