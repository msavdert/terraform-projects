variable "namespace" {
  description = "Prefix for all resources."
  type        = string
}

variable "region" {
  description = "AWS region."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (e.g. dev, prod)."
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "VPC CIDR block."
  type        = string
  default     = "20.0.0.0/16"
}

variable "azs" {
  description = "List of availability zones."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs."
  type        = list(string)
  default     = ["20.0.1.0/24", "20.0.2.0/24", "20.0.3.0/24"]
}

variable "public_subnets" {
  description = "List of public subnet CIDRs."
  type        = list(string)
  default     = ["20.0.101.0/24", "20.0.102.0/24", "20.0.103.0/24"]
}

variable "tags" {
  description = "Tags for all resources."
  type        = map(string)
  default     = {}
}

variable "create_igw" {
  description = "Enable NAT Gateway for private subnets."
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "Create a NAT Gateway across all AZs."
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "Create a single NAT Gateway across all AZs."
  type        = bool
  default     = false
}

variable "one_nat_gateway_per_az" {
  description = "Create one NAT Gateway per AZ."
  type        = bool
  default     = false
}

variable "enable_internet_gateway" {
  description = "Enable creation of an Internet Gateway for the VPC."
  type        = bool
  default     = true
}
