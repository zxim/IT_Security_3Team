# VPC ID
variable "vpc_id" {
  description = "The VPC ID where the ALB will be deployed"
  type        = string
}

# Security Group ID for ALB
variable "security_group_alb" {
  description = "The security group for the ALB"
  type        = string
}

# SSL Certificate ARN for HTTPS Listener
variable "ssl_certificate_arn" {
  description = "The ARN of the SSL certificate for HTTPS"
  type        = string
}

# ALB Target Group Name
variable "target_group_name" {
  description = "The name of the ALB target group"
  type        = string
  default     = "web-tg"
}

# ALB listener ports for HTTP and HTTPS
variable "http_listener_port" {
  description = "The port for the HTTP listener"
  type        = number
  default     = 80
}

variable "https_listener_port" {
  description = "The port for the HTTPS listener"
  type        = number
  default     = 443
}

# Subnets for the ALB
variable "public_subnets" {
  description = "The public subnets for the ALB"
  type        = list(string)
}

# Environment name (for naming resources)
variable "environment" {
  description = "The environment name (e.g., dev, prod)"
  type        = string
}

# VPC CIDR block for defining private and public subnets (Optional)
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "route53_zone_id" {
  description = "Route 53 Hosted Zone ID"
  type        = string
}

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
}