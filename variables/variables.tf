variable "region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  default     = "Vpc-Terraform"
}

variable "igw_name" {
  description = "Name tag for the Internet Gateway"
  default     = "Igw-Terraform"
}

variable "subnet_name" {
  description = "Name tag for the public subnet"
  default     = "Public-Subnet-Terraform"
}

variable "route_table_name" {
  description = "Name tag for the public route table"
  default     = "Public-Route-Table-Terraform"
}

variable "security_group_name" {
  description = "Name tag for the security group"
  default     = "allow_all"
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
  default     = "10.0.2.0/24"
}

variable "private_subnet_name" {
  description = "Name tag for the private subnet"
  default     = "Private-Subnet-Terraform"
}

variable "nat_gateway_name" {
  description = "Name tag for the NAT Gateway"
  default     = "Nat-Gateway-Terraform"
}

