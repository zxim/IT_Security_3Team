provider "aws" {
  region = var.aws_region
}

# VPC 모듈 호출
module "vpc" {
  source              = "./vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnets[0]   # public_subnet CIDR
  private_web_subnet_cidr = var.private_web_subnets[0]  # private_web_subnet CIDR
  private_rds_subnet_cidr = var.private_rds_subnets[0]  # private_rds_subnet CIDR
  ssh_key_name        = var.ssh_key_name
}


# Security Group 모듈 호출
module "security" {
  source      = "./security"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
}

# Compute 모듈 호출
module "compute" {
  source                = "./compute"
  public_subnet         = module.vpc.public_subnets[0]    # 퍼블릭 서브넷
  private_web_subnet    = module.vpc.private_web_subnets[0]  # 웹 서버가 위치할 서브넷
  security_group_web    = module.security.web_sg
  security_group_bastion = module.security.bastion_sg
  security_group_nat    = module.security.nat_sg
  security_group_ids    = module.security.ids_sg
  ssh_key_name          = var.ssh_key_name
  environment           = var.environment
}

# ALB 모듈 호출
module "alb" {
  source             = "./alb"
  vpc_id             = module.vpc.vpc_id
  public_subnets     = module.vpc.public_subnets
  security_group_alb = module.security.alb_sg
}

# RDS 모듈 호출
module "rds" {
  source             = "./rds"
  vpc_id             = module.vpc.vpc_id
  private_subnets    = module.vpc.private_rds_subnets  # RDS는 별도의 프라이빗 서브넷에서 관리
  security_group_rds = module.security.rds_sg
}
