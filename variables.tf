# variables.tf

variable "region" {
  description = "AWS region to deploy resources"
  default     = "us-east-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  default     = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "Availability zone for the subnets"
  default     = "us-east-2a"
}

variable "instance_ami" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-09040d770ffe2224f"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for the EC2 instance"
  default     = "test-project-instance"
}

variable "public_key_path" {
  description = "Path to the public key file"
  default     = "~/.ssh/id_rsa.pub"
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "Main VPC"
}

variable "public_subnet_name" {
  description = "Name of the public subnet"
  default     = "Public Subnet"
}

variable "private_subnet_name" {
  description = "Name of the private subnet"
  default     = "Private Subnet"
}

variable "security_group_name" {
  description = "Name of the security group"
  default     = "Instance Security Group"
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  default     = "Nginx Instance"
}
