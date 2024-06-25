provider "aws" {
  region = "us-east-2"  # Replace with your desired region
}
#vpc creation first in aws accont and then launch ec2 instance in vpc and then in public subnet
# VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}
#internat gateway for public subnet
# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}
#create route table and inside route table place internet gateway inside that
#Route Table for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0" #this is internet gate way
    gateway_id = aws_internet_gateway.gw.id
  }
#place tages that are not compulsory
  tags = {
    Name = "Public Route Table"
  }
}

# Associate the Public Route Table with the Public Subnet
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"  # Replace with your preferred AZ

  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2b"  # Replace with your preferred AZ

  tags = {
    Name = "Private Subnet"
  }
}

# Security Group for EC2 Instance
resource "aws_security_group" "instance_sg" {
  vpc_id = aws_vpc.main.id

  #fire wall rulls for inbound and outbound
  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH (port 22) and HTTP (port 80) inbound traffic u can also do access 
  #inbound
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Generate a new key pair
resource "aws_key_pair" "new_key_pair" {
  key_name   = "test-project-instance"
  public_key = file("~/.ssh/id_rsa.pub")
}

#now there is the main point that i want to desigre to launch the ec2 instance in public subnet
# EC2 Instance in Public Subnet
resource "aws_instance" "nginx_instance" {
  ami           = "ami-09040d770ffe2224f"  
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  key_name      = aws_key_pair.new_key_pair.key_name

#here the bash script for nginx pre installation after instance start that was the first job that server do
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install nginx -y
              sudo systemctl start nginx
              EOF

  tags = {
    Name = "Nginx Instance"
  }

  vpc_security_group_ids = [aws_security_group.instance_sg.id]
}
