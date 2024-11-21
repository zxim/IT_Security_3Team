variable "alb_dns_name" {
  description = "The DNS name of the ALB"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS"
  type        = string
}

variable "cloudfront_price_class" {
  description = "Price class for CloudFront"
  type        = string
}

variable "s3_logging_bucket" {
  description = "S3 bucket for CloudFront logs"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}
