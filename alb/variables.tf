# ALB 관련 변수 정의

variable "public_subnets" {
  description = "List of public subnets across multiple AZs"
  type        = list(string)
}

variable "security_group_alb" {
  description = "Security group for ALB"
}

variable "vpc_id" {
  description = "VPC ID"
}
