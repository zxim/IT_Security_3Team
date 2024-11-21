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

# SSH Key Name
variable "ssh_key_name_bastion" {
  description = "SSH key pair name"
  type        = string
}

variable "ssh_key_name_web" {
  description = "SSH key pair name"
  type        = string
}

variable "ssh_key_name_app" {
  description = "SSH key pair name"
  type        = string
}

# Public Subnets
variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = ["192.168.1.0/24", "192.168.4.0/24"]
}

# Private Web Subnets
variable "private_web_subnets" {
  description = "Private subnet CIDR blocks for web servers"
  type        = list(string)
  default     = ["192.168.2.0/24", "192.168.5.0/24"]
}

# Private RDS Subnets
variable "private_rds_subnets" {
  description = "Private subnet CIDR blocks for RDS"
  type        = list(string)
  default     = ["192.168.3.0/24", "192.168.6.0/24"]
}

# Database Username
variable "db_username" {
  description = "Username for the RDS instance"
  type        = string
}

# Database Password
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