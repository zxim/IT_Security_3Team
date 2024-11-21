# AWS Region
variable "aws_region" {
  description = "AWS region (e.g., ap-northeast-2 for Seoul)"
  type        = string
  default     = "ap-northeast-2"
}

# VPC CIDR
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16"
}

# Environment
variable "environment" {
  description = "Environment tag (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

# SSH Key Names
variable "ssh_key_name_bastion" {
  description = "SSH key pair name for Bastion host"
  type        = string
}

variable "ssh_key_name_web" {
  description = "SSH key pair name for Web servers"
  type        = string
}

variable "ssh_key_name_app" {
  description = "SSH key pair name for Application servers"
  type        = string
}

# Subnet CIDRs
variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = ["192.168.1.0/24", "192.168.4.0/24"]
}

variable "private_web_subnets" {
  description = "Private subnet CIDR blocks for Web servers"
  type        = list(string)
  default     = ["192.168.2.0/24", "192.168.5.0/24"]
}

variable "private_rds_subnets" {
  description = "Private subnet CIDR blocks for RDS"
  type        = list(string)
  default     = ["192.168.3.0/24", "192.168.6.0/24"]
}

# Database Access
variable "db_username" {
  description = "Username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "Password for the RDS instance"
  type        = string
  sensitive   = true
}

# SSH Access CIDR
variable "allowed_ssh_cidr" {
  description = "Allowed CIDR block for SSH access"
  type        = string
  default     = "0.0.0.0/0"
}

# ALB Traffic Ports
variable "alb_http_port" {
  description = "Port for ALB HTTP traffic"
  type        = number
  default     = 80
}

variable "alb_https_port" {
  description = "Port for ALB HTTPS traffic"
  type        = number
  default     = 443
}

# CloudFront Settings
variable "cloudfront_price_class" {
  description = "CloudFront price class (e.g., PriceClass_100, PriceClass_200, PriceClass_All)"
  default     = "PriceClass_100"
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS"
  type        = string
}

# WAF Settings
variable "waf_acl_name" {
  description = "Name of the WAF ACL"
  type        = string
  default     = "default-waf-acl"
}

variable "waf_managed_rule_groups" {
  description = "List of WAF managed rule groups"
  type        = list(object({
    name        = string
    vendor_name = string
  }))
  default = [
    {
      name        = "AWSManagedRulesCommonRuleSet"
      vendor_name = "AWS"
    },
    {
      name        = "AWSManagedRulesSQLiRuleSet"
      vendor_name = "AWS"
    }
  ]
}
variable "s3_logging_bucket" {
  description = "S3 bucket for CloudFront logs"
  type        = string
}
variable "route53_domain_name" {
  description = "Domain name for Route 53"
  type        = string
}
variable "alb_arn" {
  description = "The ARN of the ALB"
  type        = string
}
