# VPC ID
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

# Environment name (e.g., dev, prod)
variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

# ALB HTTP port
variable "alb_http_port" {
  description = "HTTP port for ALB"
  type        = number
  default     = 80
}

# ALB HTTPS port
variable "alb_https_port" {
  description = "HTTPS port for ALB"
  type        = number
  default     = 443
}

# Allowed SSH CIDR block
variable "allowed_ssh_cidr" {
  description = "Allowed CIDR block for SSH access"
  type        = string
  default     = "0.0.0.0/0"
}

# Web server private IP (AZ1)
variable "web1_private_ip" {
  description = "Private IP of Web Server in AZ1"
  type        = string
  default     = "192.168.10.10"
}

# Web server private IP (AZ2)
variable "web2_private_ip" {
  description = "Private IP of Web Server in AZ2"
  type        = string
  default     = "192.168.20.10"
}

# Web server subnet CIDR (AZ1)
variable "web_subnet_ip" {
  description = "CIDR block for web server subnet in AZ1"
  type        = string
  default     = "192.168.10.0/24"
}

# Web server subnet CIDR (AZ2)
variable "web_subnet_ip_az2" {
  description = "CIDR block for web server subnet in AZ2"
  type        = string
  default     = "192.168.20.0/24"
}

# App server subnet CIDR (AZ1)
variable "app_subnet_ip" {
  description = "CIDR block for application server subnet in AZ1"
  type        = string
  default     = "192.168.30.0/24"
}

# App server subnet CIDR (AZ2)
variable "app_subnet_ip_az2" {
  description = "CIDR block for application server subnet in AZ2"
  type        = string
  default     = "192.168.40.0/24"
}

# RDS subnet CIDR
variable "rds_subnet_ip" {
  description = "CIDR block for RDS subnet"
  type        = string
  default     = "192.168.50.0/24"
}

# Database username
variable "db_username" {
  description = "RDS username"
  type        = string
}

# Database password
variable "db_password" {
  description = "RDS password"
  type        = string
  sensitive   = true
}
