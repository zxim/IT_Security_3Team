variable "aws_region" {
  default = "ap-northeast-2"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "environment" {
  default = "dev"
}

variable "ssh_key_name" {
  description = "Key pair for the Bastion host"
  type        = string
}

