# EC2 및 Bastion Host 변수 정의

variable "vpc_id" {
  description = "The ID of the VPC where compute instances are deployed"
  type        = string
}

variable "private_web_subnets" {
  description = "List of private subnets for web and IDS/IPS instances"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
}

variable "security_group_web" {
  description = "Security group for web servers"
  type        = string
}

variable "security_group_bastion" {
  description = "Security group for the bastion host"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}
