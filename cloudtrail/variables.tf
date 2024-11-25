# 환경 이름 (dev, staging, prod)
variable "environment" {
  description = "Environment name for CloudTrail setup"
  type        = string
  default     = "dev"
}

# CloudWatch Role ARN
variable "cloudtrail_cloudwatch_role_arn" {
  description = "IAM Role ARN for CloudTrail to send logs to CloudWatch"
  type        = string
}
