variable "private_web_subnet" {
  description = "The ID of the private subnet for web servers"
  type        = string
}

variable "public_subnet" {
  description = "The ID of the public subnet for NAT and Bastion"
  type        = string
}

variable "security_group_web" {
  description = "The security group for web servers"
  type        = string
}

variable "security_group_nat" {
  description = "The security group for NAT instance"
  type        = string
}

variable "security_group_bastion" {
  description = "The security group for Bastion host"
  type        = string
}

variable "security_group_ids" {
  description = "The security group for IDS/IPS"
  type        = string
}

variable "ssh_key_name" {
  description = "The SSH key pair name used for accessing EC2 instances"
  type        = string
}

variable "web_instance_type" {
  description = "Instance type for web servers"
  type        = string
  default     = "t3.micro"
}

variable "environment" {
  description = "The environment for tagging resources (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}
