variable "region" {
  description = "The AWS region to deploy to"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "public_subnet_name" {
  description = "The name for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
}

variable "private_subnet_name" {
  description = "The name for the private subnet"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone for the subnets"
  type        = string
}

variable "security_group_name" {
  description = "The name for the security group"
  type        = string
}

variable "key_name" {
  description = "The name for the key pair"
  type        = string
}

variable "public_key_path" {
  description = "The path to the public key file"
  type        = string
}

variable "instance_ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
}

variable "instance_name" {
  description = "The name for the EC2 instance"
  type        = string
}
