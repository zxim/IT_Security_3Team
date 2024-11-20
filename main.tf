provider "aws" {
  region = var.aws_region
}

# VPC 모듈 호출
module "vpc" {
  source                   = "./vpc"
  vpc_cidr                 = var.vpc_cidr
  public_subnet_cidr_az1   = var.public_subnets[0]        # 첫 번째 퍼블릭 서브넷 CIDR
  public_subnet_cidr_az2   = var.public_subnets[1]        # 두 번째 퍼블릭 서브넷 CIDR
  private_web_subnet_cidr_az1 = var.private_web_subnets[0] # 첫 번째 프라이빗 웹 서브넷 CIDR
  private_web_subnet_cidr_az2 = var.private_web_subnets[1] # 두 번째 프라이빗 웹 서브넷 CIDR
  private_rds_subnet_cidr_az1 = var.private_rds_subnets[0] # 첫 번째 프라이빗 RDS 서브넷 CIDR
  private_rds_subnet_cidr_az2 = var.private_rds_subnets[1] # 두 번째 프라이빗 RDS 서브넷 CIDR
  ssh_key_name             = var.ssh_key_name
  environment              = var.environment
}


# Security Group 모듈 호출
module "security" {
  source               = "./security"
  vpc_id               = module.vpc.vpc_id
  web1_private_ip      = module.compute.web_instance_private_ips[0] # 첫 번째 웹 서버 IP 전달
  web2_private_ip      = module.compute.web_instance_private_ips[1] # 두 번째 웹 서버 IP 전달
  environment          = var.environment
}

# Compute 모듈 호출
module "compute" {
  source                = "./compute"
  public_subnet         = [module.vpc.public_subnet_az1_id] # AZ1 서브넷 전달
  private_web_subnet_az1 = module.vpc.private_web_subnet_az1_id # AZ1 서브넷 전달
  private_web_subnet_az2 = module.vpc.private_web_subnet_az2_id # AZ2 서브넷 전달
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
  public_subnets     = [module.vpc.public_subnet_az1_id, module.vpc.public_subnet_az2_id] # 퍼블릭 서브넷 IDs
  security_group_alb = module.security.alb_sg
}

# RDS 모듈 호출
module "rds" {
  source             = "./rds"
  vpc_id             = module.vpc.vpc_id
  private_subnets    = [module.vpc.private_rds_subnet_az1_id, module.vpc.private_rds_subnet_az2_id] # RDS 서브넷 IDs
  security_group_rds = module.security.rds_sg
  private_rds_az1    = module.vpc.private_rds_subnet_az1_id
  private_rds_az2    = module.vpc.private_rds_subnet_az2_id
  db_username        = var.db_username
  db_password        = var.db_password
}
