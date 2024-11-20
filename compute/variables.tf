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

# 기타 변수
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
