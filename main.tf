provider "aws" {
  region = var.aws_region
}

# VPC 모듈 호출
module "vpc" {
  source = "./vpc"

  vpc_cidr           = var.vpc_cidr
  public_subnets     = ["192.168.1.0/24", "192.168.2.0/24"]
  private_web_subnets = ["192.168.3.0/24", "192.168.4.0/24"]
  private_rds_subnets = ["192.168.5.0/24", "192.168.6.0/24"]
}

# Security Group 모듈 호출
module "security" {
  source      = "./security"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
}

# Compute 모듈 호출 (EC2, Auto Scaling Group, IDS/IPS)
module "compute" {
  source               = "./compute"
  vpc_id               = module.vpc.vpc_id
  private_web_subnets  = module.vpc.private_web_subnets
  public_subnets       = module.vpc.public_subnets
  security_group_web   = module.security.web_sg
  security_group_bastion = module.security.bastion_sg
  ssh_key_name         = var.ssh_key_name
}

# ALB 모듈 호출
module "alb" {
  source               = "./alb"
  vpc_id               = module.vpc.vpc_id
  public_subnets       = module.vpc.public_subnets
  security_group_alb   = module.security.alb_sg
}

# RDS 모듈 호출
module "rds" {
  source               = "./rds"
  vpc_id               = module.vpc.vpc_id
  private_subnets      = module.vpc.private_rds_subnets
  security_group_rds   = module.security.rds_sg
}

output "bastion_instance_id" {
  description = "ID of the Bastion Host instance"
  value       = module.compute.bastion_instance_id
}

# Output 모듈 호출
output "ids_ips_instance_id" {
  description = "ID of the IDS/IPS instance"
  value       = module.compute.ids_ips_instance_id
}

output "ids_ips_private_ip" {
  description = "Private IP of the IDS/IPS instance"
  value       = module.compute.ids_ips_private_ip
}
