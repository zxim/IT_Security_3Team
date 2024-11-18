# 출력값 정의 파일

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_web_subnets" {
  value = module.vpc.private_web_subnets
}

output "private_rds_subnets" {
  value = module.vpc.private_rds_subnets
}



