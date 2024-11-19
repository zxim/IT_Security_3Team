# AWS 리전 설정
variable "aws_region" {
  description = "AWS 리전 (예: 서울 리전)"
  type        = string
  default     = "ap-northeast-2" # 서울 리전
}

# VPC CIDR 설정
variable "vpc_cidr" {
  description = "기본 VPC의 CIDR 블록"
  type        = string
  default     = "192.168.0.0/16" # 넓은 대역폭을 기본값으로 설정
}

# 환경 태그 설정
variable "environment" {
  description = "리소스 태그에 사용할 환경 (예: dev, staging, prod)"
  type        = string
  default     = "dev" # 기본값: 개발 환경
}

# SSH 키 페어 이름
variable "ssh_key_name" {
  description = "EC2 인스턴스에 접근하기 위한 SSH 키 페어 이름"
  type        = string
}

# 퍼블릭 서브넷 CIDR 설정 (NAT 및 ALB 용도)
variable "public_subnets" {
  description = "퍼블릭 서브넷 CIDR 블록 (NAT 및 ALB 용도)"
  type        = list(string)
  default     = ["192.168.1.0/24"] # 퍼블릭 서브넷
}

# 웹 서버 및 IPS 서브넷 CIDR 설정
variable "private_web_subnets" {
  description = "웹 서버 및 IPS를 위한 프라이빗 서브넷 CIDR 블록"
  type        = list(string)
  default     = ["192.168.2.0/24"] # 웹 서버 및 IPS 서브넷
}

# RDS 서브넷 CIDR 설정
variable "private_rds_subnets" {
  description = "RDS를 위한 프라이빗 서브넷 CIDR 블록"
  type        = list(string)
  default     = ["192.168.3.0/24"] # RDS 서브넷
}

# 가용 영역 설정
variable "availability_zones" {
  description = "리소스를 분배할 가용 영역 목록"
  type        = list(string)
  default     = ["ap-northeast-2a"] # 단일 가용 영역
}
