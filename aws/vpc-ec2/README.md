# AWS VPC and EC2 Instance Terraform Module

This Terraform project creates a complete AWS network infrastructure with VPC and deploys an EC2 instance.

## Architecture

This project provisions:
- A custom VPC with public and private subnets
- Internet Gateway for public subnet access
- Security Groups with configurable rules
- SSH Key Pair for secure instance access
- EC2 instance with customizable settings

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) v1.0+
- AWS CLI configured with appropriate credentials
- Basic knowledge of AWS services and Terraform

## Usage

1. **Clone the repository**

```bash
git clone <repository-url>
cd vpc-ec2
```

2. **Initialize Terraform**

```bash
terraform init
```

3. **Review and modify configuration**

Update the `terraform.tfvars` file to customize your deployment.

4. **Plan the deployment**

```bash
terraform plan
```

5. **Apply the configuration**

```bash
terraform apply
```

6. **Accessing your instance**

After successful creation, the private key will be available in your project root directory. 
Use it to SSH into your instance:

```bash
chmod 600 my-key-pair
ssh -i my-key-pair ec2-user@<instance-public-ip>
```

The instance public IP will be available in the outputs.

## Configuration Options

The project can be customized via the following variables in `terraform.tfvars`:

| Variable | Description |
|----------|-------------|
| region | AWS region to deploy resources |
| namespace | Prefix for resource names |
| tags | Tags to apply to all resources |
| vpc_name | Name of the VPC |
| vpc_cidr | CIDR block for the VPC |
| private_subnets | List of private subnet CIDR blocks |
| public_subnets | List of public subnet CIDR blocks |
| enable_nat_gateway | Whether to create NAT gateways |
| security_group_name | Name of the security group |
| security_group_description | Description of the security group |
| custom_ports | List of ports to open in the security group |
| key_name | Name of the SSH key pair |
| instance_name | Name of the EC2 instance |
| instance_type | EC2 instance type |
| ami_id | AMI ID for the EC2 instance |
| associate_public_ip_address | Whether to assign a public IP to the instance |
| root_block_device | Configuration for the root block device |

## Project Structure

```
.
├── main.tf           # Main Terraform configuration
├── variables.tf      # Variable definitions
├── outputs.tf        # Output definitions
├── terraform.tfvars  # Variable values
└── README.md         # This readme file
```

## Security Considerations

- The private key is stored locally. Keep it secure and consider using AWS Systems Manager Parameter Store for production environments.
- Security groups are configured with restrictive inbound rules by default.
- Always use specific CIDR blocks for SSH access instead of 0.0.0.0/0.

## Cleanup

To destroy all resources created by this project:

```bash
terraform destroy
```

## Contributing

Feel free to submit issues or pull requests for enhancements or fixes.

## License

This project is licensed under the MIT License - see the LICENSE file for details.