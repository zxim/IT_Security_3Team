variable "vpc_id" {
  description = "The ID of the VPC where compute instances are deployed"
  type        = string
}

variable "private_web_subnets" {
  description = "List of private subnets for web servers"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
}

variable "security_group_web" {
  description = "Security group for web servers"
  type        = string
}

variable "security_group_bastion" {
  description = "Security group for the bastion host"
  type        = string
}

variable "ssh_key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "web_instance_type" {
  description = "Instance type for web instances"
  default     = "t3.micro"
}

variable "desired_capacity" {
  description = "Desired number of web instances in Auto Scaling Group"
  default     = 3
}

variable "min_capacity" {
  description = "Minimum number of web instances in Auto Scaling Group"
  default     = 2
}

variable "max_capacity" {
  description = "Maximum number of web instances in Auto Scaling Group"
  default     = 10
}
