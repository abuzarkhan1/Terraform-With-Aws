provider "aws" {
  region = var.region
}

# VPC
resource "aws_vpc" "Vpc-Terraform" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "Igw-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  tags = {
    Name = var.igw_name
  }
}

# Public Subnet
resource "aws_subnet" "Public-Subnet-Terraform" {
  vpc_id                  = aws_vpc.Vpc-Terraform.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_name
  }
}

# Private Subnet
resource "aws_subnet" "Private-Subnet-Terraform" {
  vpc_id     = aws_vpc.Vpc-Terraform.id
  cidr_block = var.private_subnet_cidr_block

  tags = {
    Name = var.private_subnet_name
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "Nat-EIP" {
  vpc = true
}

# NAT Gateway
resource "aws_nat_gateway" "Nat-Gateway-Terraform" {
  allocation_id = aws_eip.Nat-EIP.id
  subnet_id     = aws_subnet.Public-Subnet-Terraform.id

  tags = {
    Name = var.nat_gateway_name
  }
}

# Public Route Table
resource "aws_route_table" "Public-Route-Table-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Igw-Terraform.id
  }

  tags = {
    Name = var.route_table_name
  }
}

# Private Route Table
resource "aws_route_table" "Private-Route-Table-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.Nat-Gateway-Terraform.id
  }

  tags = {
    Name = "Private-Route-Table-Terraform"
  }
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "Public-Route-Table-Association" {
  subnet_id      = aws_subnet.Public-Subnet-Terraform.id
  route_table_id = aws_route_table.Public-Route-Table-Terraform.id
}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "Private-Route-Table-Association" {
  subnet_id      = aws_subnet.Private-Subnet-Terraform.id
  route_table_id = aws_route_table.Private-Route-Table-Terraform.id
}

# Security Group
resource "aws_security_group" "allow_all" {
  name        = var.security_group_name
  description = "Allow all inbound and outbound traffic"
  vpc_id      = aws_vpc.Vpc-Terraform.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
  }
}
