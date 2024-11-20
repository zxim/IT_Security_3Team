# RDS 관련 변수 정의

# 여러 서브넷을 지원하도록 수정
variable "private_subnets" {
  description = "List of private subnet IDs across multiple AZs for RDS"
  type        = list(string)
}

# VPC ID
variable "vpc_id" {
  description = "The ID of the VPC where RDS will be deployed"
  type        = string
}

# RDS용 Security Group
variable "security_group_rds" {
  description = "Security group for RDS"
  type        = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
  sensitive = true
}

variable "private_rds_az1" {
  description = "Private RDS subnet ID in AZ1"
  type        = string
}

variable "private_rds_az2" {
  description = "Private RDS subnet ID in AZ2"
  type        = string
}
