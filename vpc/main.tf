provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "Vpc-Terraform" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "Vpc-Terraform"
  }
}

resource "aws_internet_gateway" "Igw-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  tags = {
    Name = "Igw-Terraform"
  }
}

resource "aws_subnet" "Public-Subnet-Terraform" {
  vpc_id     = aws_vpc.Vpc-Terraform.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Public-Subnet-Terraform"
  }
}

resource "aws_route_table" "Public-Route-Table-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Igw-Terraform.id
  }

  tags = {
    Name = "Public-Route-Table-Terraform"
  }
}

resource "aws_route_table_association" "Public-Route-Table-Association" {
  subnet_id      = aws_subnet.Public-Subnet-Terraform.id
  route_table_id = aws_route_table.Public-Route-Table-Terraform.id
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
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
    Name = "allow_all"
  }
}
