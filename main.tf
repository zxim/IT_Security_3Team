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

# 보안 그룹 모듈 호출
module "security" {
  source      = "./security"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
}

# Compute 모듈 호출 (EC2 및 Bastion Host)
module "compute" {
  source               = "./compute"
  vpc_id               = module.vpc.vpc_id
  private_web_subnets  = module.vpc.private_web_subnets
  public_subnets       = module.vpc.public_subnets
  security_group_web   = module.security.web_sg
  security_group_bastion = module.security.bastion_sg
  security_group_ids   = [module.security.web_sg, module.security.bastion_sg] # 필요한 Security Group IDs 추가
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
