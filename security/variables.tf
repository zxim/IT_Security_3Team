# VPC ID
variable "vpc_id" {
  description = "The ID of the VPC where the security groups will be created"
  type        = string
}

# 환경 설정 (예: dev, staging, prod)
variable "environment" {
  description = "The environment for tagging resources (e.g., dev, staging, prod)"
  type        = string
  default     = "dev" # Default: Development environment
}

# SSH 접근 허용 CIDR
variable "allowed_ssh_cidr" {
  description = "The CIDR block allowed for SSH access (e.g., office or specific IP range)"
  type        = string
  default     = "0.0.0.0/0" # Default allows all IPs (should be restricted for security)
}

# RDS 접근 허용 CIDR
variable "allowed_rds_cidr" {
  description = "The CIDR block allowed for RDS access (e.g., internal VPC network)"
  type        = string
  default     = "10.0.0.0/16" # Default allows internal VPC access
}

# ALB HTTP 포트
variable "alb_http_port" {
  description = "The port for HTTP access to the ALB"
  type        = number
  default     = 80 # Default HTTP port
}

# ALB HTTPS 포트
variable "alb_https_port" {
  description = "The port for HTTPS access to the ALB"
  type        = number
  default     = 443 # Default HTTPS port
}

variable "web1_private_ip" {
  description = "Private IP of Web Server 1"
  type        = string
}

variable "web2_private_ip" {
  description = "Private IP of Web Server 2"
  type        = string
}
