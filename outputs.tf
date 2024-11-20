# VPC 출력
output "vpc_id" {
  description = "VPC의 ID"
  value       = module.vpc.vpc_id
}

# 퍼블릭 서브넷 출력 (AZ1, AZ2 개별적으로 출력)
output "public_subnet_az1_id" {
  description = "퍼블릭 서브넷 AZ1의 ID"
  value       = module.vpc.public_subnet_az1_id
}

output "public_subnet_az2_id" {
  description = "퍼블릭 서브넷 AZ2의 ID"
  value       = module.vpc.public_subnet_az2_id
}

# 웹 서버 서브넷 출력 (AZ1, AZ2 개별적으로 출력)
output "private_web_subnet_az1_id" {
  description = "웹 서버 서브넷 AZ1의 ID"
  value       = module.vpc.private_web_subnet_az1_id
}

output "private_web_subnet_az2_id" {
  description = "웹 서버 서브넷 AZ2의 ID"
  value       = module.vpc.private_web_subnet_az2_id
}

# RDS 서브넷 출력 (AZ1, AZ2 개별적으로 출력)
output "private_rds_subnet_az1_id" {
  description = "RDS 서브넷 AZ1의 ID"
  value       = module.vpc.private_rds_subnet_az1_id
}

output "private_rds_subnet_az2_id" {
  description = "RDS 서브넷 AZ2의 ID"
  value       = module.vpc.private_rds_subnet_az2_id
}

# ALB 출력
output "alb_dns_name" {
  description = "ALB의 DNS 이름"
  value       = module.alb.alb_dns_name
}

# Compute 출력
output "web_instance_ids" {
  description = "웹 서버 인스턴스의 ID 목록"
  value       = module.compute.web_instance_ids
}

output "web_instance_private_ips" {
  description = "웹 서버 인스턴스의 프라이빗 IP 목록"
  value       = module.compute.web_instance_private_ips
}

# RDS 출력
output "rds_endpoint" {
  description = "RDS 엔드포인트"
  value       = module.rds.rds_endpoint
}
