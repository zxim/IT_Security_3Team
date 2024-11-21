provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source                     = "./vpc"
  vpc_cidr                   = var.vpc_cidr
  public_subnet_cidr_az1     = var.public_subnets[0]
  public_subnet_cidr_az2     = var.public_subnets[1]
  private_web_subnet_cidr_az1 = var.private_web_subnets[0]
  private_web_subnet_cidr_az2 = var.private_web_subnets[1]
  private_rds_subnet_cidr_az1 = var.private_rds_subnets[0]
  private_rds_subnet_cidr_az2 = var.private_rds_subnets[1]
  environment                = var.environment
  route53_domain_name        = var.route53_domain_name  # 추가
}

module "security" {
  source        = "./security"
  vpc_id        = module.vpc.vpc_id
  environment   = var.environment
  alb_http_port = var.alb_http_port
  alb_https_port = var.alb_https_port
  allowed_ssh_cidr = var.allowed_ssh_cidr

  db_username = var.db_username
  db_password = var.db_password

  alb_arn = module.alb.alb_arn
}

module "compute" {
  source                 = "./compute"
  public_subnet          = [module.vpc.public_subnet_cidr_az1, module.vpc.public_subnet_cidr_az2]
  private_web_subnet_az1 = module.vpc.private_web_subnet_cidr_az1
  private_web_subnet_az2 = module.vpc.private_web_subnet_cidr_az2
  security_group_web     = module.security.web_sg
  security_group_bastion = module.security.bastion_sg
  security_group_app     = module.security.app_sg
  ssh_key_name_bastion  = var.ssh_key_name_bastion
  ssh_key_name_web      = var.ssh_key_name_web
  ssh_key_name_app      = var.ssh_key_name_app
  environment            = var.environment
}

module "alb" {
  source             = "./alb"
  vpc_id             = module.vpc.vpc_id
  public_subnets     = [module.vpc.public_subnet_az1_id, module.vpc.public_subnet_az2_id]
  security_group_alb = module.security.alb_sg
  environment        = var.environment
}

module "rds" {
  source             = "./rds"
  vpc_id             = module.vpc.vpc_id
  private_subnets    = [module.vpc.private_rds_subnet_az1_id, module.vpc.private_rds_subnet_az2_id]
  security_group_rds = module.security.rds_sg
  private_rds_az1    = module.vpc.private_rds_subnet_az1_id
  private_rds_az2    = module.vpc.private_rds_subnet_az2_id
  db_username        = var.db_username
  db_password        = var.db_password
}

module "cloudfront" {
  source                  = "./cloudfront"
  alb_dns_name            = module.alb.alb_dns_name
  environment             = var.environment
  cloudfront_price_class  = var.cloudfront_price_class
  acm_certificate_arn     = var.acm_certificate_arn
  s3_logging_bucket       = var.s3_logging_bucket  # S3 로그 버킷 이름 추가
}
