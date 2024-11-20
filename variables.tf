# AWS 리전 설정
variable "aws_region" {
  description = "AWS 리전 (예: 서울 리전)"
  type        = string
  default     = "ap-northeast-2"
}

# VPC CIDR 설정
variable "vpc_cidr" {
  description = "VPC의 CIDR 블록"
  type        = string
  default     = "192.168.0.0/16"
}

# 환경 태그
variable "environment" {
  description = "리소스 태그 환경 (예: dev, staging, prod)"
  type        = string
  default     = "dev"
}

# SSH 키 이름
variable "ssh_key_name" {
  description = "SSH 키 페어 이름"
  type        = string
}

# 퍼블릭 서브넷
variable "public_subnets" {
  description = "퍼블릭 서브넷 CIDR 블록"
  type        = list(string)
  default     = [
    "192.168.1.0/24",
    "192.168.4.0/24"
  ]
}

# 프라이빗 웹 서버 서브넷
variable "private_web_subnets" {
  description = "웹 서버를 위한 프라이빗 서브넷 CIDR 블록"
  type        = list(string)
  default     = [
    "192.168.2.0/24",
    "192.168.5.0/24"
  ]
}

# 프라이빗 RDS 서브넷
variable "private_rds_subnets" {
  description = "RDS를 위한 프라이빗 서브넷 CIDR 블록"
  type        = list(string)
  default     = [
    "192.168.3.0/24",
    "192.168.6.0/24"
  ]
}

# 데이터베이스 사용자 이름
variable "db_username" {
  description = "RDS 사용자 이름"
  type        = string
}

# 데이터베이스 비밀번호
variable "db_password" {
  description = "RDS 사용자 비밀번호"
  type        = string
  sensitive   = true
}
