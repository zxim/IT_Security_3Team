# VPC CIDR
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16" # 기본 VPC CIDR
}

# 퍼블릭 서브넷 CIDR 및 AZ
variable "public_subnet_cidr_az1" {
  description = "CIDR block for the public subnet in AZ1"
  type        = string
  default     = "192.168.1.0/24"
}

variable "public_subnet_cidr_az2" {
  description = "CIDR block for the public subnet in AZ2"
  type        = string
  default     = "192.168.2.0/24"
}

# 프라이빗 웹 서브넷 CIDR 및 AZ
variable "private_web_subnet_cidr_az1" {
  description = "CIDR block for the private web subnet in AZ1"
  type        = string
  default     = "192.168.10.0/24" # 충돌 방지를 위해 CIDR 수정
}

variable "private_web_subnet_cidr_az2" {
  description = "CIDR block for the private web subnet in AZ2"
  type        = string
  default     = "192.168.11.0/24" # 충돌 방지를 위해 CIDR 수정
}

# 프라이빗 RDS 서브넷 CIDR 및 AZ
variable "private_rds_subnet_cidr_az1" {
  description = "CIDR block for the private RDS subnet in AZ1"
  type        = string
  default     = "192.168.20.0/24" # 충돌 방지를 위해 CIDR 수정
}

variable "private_rds_subnet_cidr_az2" {
  description = "CIDR block for the private RDS subnet in AZ2"
  type        = string
  default     = "192.168.21.0/24" # 충돌 방지를 위해 CIDR 수정
}

# SSH 키 이름
variable "ssh_key_name" {
  description = "Key name for accessing instances"
  type        = string
}

# 환경 태그
variable "environment" {
  description = "Environment tag for resources (e.g., dev, staging, prod)"
  type        = string
  default     = "dev" # 기본값으로 개발 환경 설정
}
