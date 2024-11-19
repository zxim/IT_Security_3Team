variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "192.168.1.0/24" # 기본값 설정 (필요 시 수정)
}

variable "private_web_subnet_cidr" {
  description = "CIDR block for the private subnet used by web servers and IDS"
  type        = string
  default     = "192.168.2.0/24" # 기본값 설정 (필요 시 수정)
}

variable "private_rds_subnet_cidr" {
  description = "CIDR block for the private subnet used by RDS"
  type        = string
  default     = "192.168.3.0/24" # 기본값 설정 (필요 시 수정)
}

variable "nat_instance_type" {
  description = "Instance type for the NAT instance"
  type        = string
  default     = "t3.micro"
}

variable "ssh_key_name" {
  description = "Key name for accessing instances"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone to deploy resources"
  type        = string
  default     = "ap-northeast-2a"
}
