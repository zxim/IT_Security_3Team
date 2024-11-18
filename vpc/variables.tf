variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "private_web_subnets" {
  description = "List of private web subnet CIDR blocks"
  type        = list(string)
}

variable "private_rds_subnets" {
  description = "List of private RDS subnet CIDR blocks"
  type        = list(string)
}

