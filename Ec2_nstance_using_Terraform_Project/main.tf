   provider "aws" {
     region = "us-east-1"  # Set your desired AWS region
   }

   resource "aws_instance" "example" {
     ami           = "ami-04a81a99f5ec58529"  
     instance_type = "t2.medium"
     subnet_id = "subnet-0b95066b045e1d911"
     key_name = "abuzar"
   }