variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr_az1" {
  description = "CIDR block for public subnet in AZ1"
  type        = string
}

variable "public_subnet_cidr_az2" {
  description = "CIDR block for public subnet in AZ2"
  type        = string
}

variable "private_rds_subnet_cidr_az1" {
  description = "CIDR block for private RDS subnet in AZ1"
  type        = string
}

variable "private_rds_subnet_cidr_az2" {
  description = "CIDR block for private RDS subnet in AZ2"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "private_web_subnet_cidr_az1" {
  description = "CIDR block for private web subnet in AZ1"
  type        = string
}

variable "private_web_subnet_cidr_az2" {
  description = "CIDR block for private web subnet in AZ2"
  type        = string
}

# Route 53 도메인 변수 추가
variable "route53_domain_name" {
  description = "The domain name to use in Route 53 (e.g., mymain.click)"
  type        = string
}
