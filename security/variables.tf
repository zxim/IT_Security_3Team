variable "vpc_id" {
  description = "The ID of the VPC where the security groups will be created"
  type        = string
}

variable "environment" {
  description = "The environment for tagging resources (e.g., dev, staging, prod)"
  type        = string
}
