# VPC 관련 출력값
output "vpc_id" {
  description = "VPC 모듈에서 생성된 VPC의 ID"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "VPC 모듈에서 생성된 퍼블릭 서브넷의 ID 목록"
  value       = module.vpc.public_subnets
}

output "private_web_subnets" {
  description = "웹 서버와 IDS/IPS를 위한 프라이빗 서브넷의 ID 목록"
  value       = module.vpc.private_web_subnets
}

output "private_rds_subnets" {
  description = "RDS를 위한 프라이빗 서브넷의 ID 목록"
  value       = module.vpc.private_rds_subnets
}

# Bastion Host 출력값
output "bastion_instance_id" {
  description = "Bastion Host 인스턴스의 ID"
  value       = module.compute.bastion_instance_id
}

output "bastion_public_ip" {
  description = "Bastion Host 인스턴스의 퍼블릭 IP 주소"
  value       = module.compute.bastion_public_ip
}

# IDS/IPS 출력값
output "ids_instance_ids" {
  description = "List of IDs for IDS/IPS instances created by the Compute module"
  value       = module.compute.ids_instance_ids
}

output "ids_instance_private_ips" {
  description = "List of private IPs for IDS/IPS instances created by the Compute module"
  value       = module.compute.ids_instance_private_ips
}


# ALB 출력값
output "alb_dns_name" {
  description = "애플리케이션 로드 밸런서(ALB)의 DNS 이름"
  value       = module.alb.alb_dns_name
}

# RDS 출력값
output "rds_endpoint" {
  description = "RDS 인스턴스의 엔드포인트 URL"
  value       = module.rds.rds_endpoint
}
