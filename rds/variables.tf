# RDS 관련 변수 정의

variable "private_subnets" {
  description = "List of private subnets across multiple AZs"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC where RDS will be deployed"
  type        = string
}


variable "security_group_rds" {
  description = "Security group for RDS"
}
