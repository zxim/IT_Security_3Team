# ALB 관련 변수 정의

variable "public_subnets" {
  description = "퍼블릭 서브넷 ID 목록"
  type        = list(string)
}

variable "security_group_alb" {
  description = "ALB용 보안 그룹 ID"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS"
  type        = string
}

variable "s3_logging_bucket" {
  description = "S3 bucket for CloudFront logs"
  type        = string
}

# ALB ARN 추가 (Main.tf에서 전달)
variable "alb_arn" {
  description = "ARN of the Application Load Balancer"
  type        = string
}
