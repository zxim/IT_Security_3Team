# 서브넷 변수
variable "private_web_subnet_az1" {
  description = "The ID of the private subnet for web servers in AZ1"
  type        = string
}

variable "private_web_subnet_az2" {
  description = "The ID of the private subnet for web servers in AZ2"
  type        = string
}

variable "public_subnet" {
  description = "The ID of the public subnet for NAT and Bastion"
  type        = list(string)
}

# 보안 그룹 변수
variable "security_group_web" {
  description = "Web security group ID"
  type        = string
}

variable "security_group_bastion" {
  description = "The security group for Bastion host"
  type        = string
}

variable "security_group_app" {
  description = "Application server security group ID"
  type        = string
}

# 기타 변수
variable "ssh_key_name_bastion" {
  description = "The SSH key pair name used for accessing EC2 instances"
  type        = string
}

variable "ssh_key_name_web" {
  description = "The SSH key pair name used for accessing EC2 instances"
  type        = string
}

variable "ssh_key_name_app" {
  description = "The SSH key pair name used for accessing EC2 instances"
  type        = string
}

variable "web_instance_type" {
  description = "Instance type for web servers and application servers"
  type        = string
  default     = "t3.micro"
}

variable "environment" {
  description = "The environment for tagging resources (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

