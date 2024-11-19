# VPC ID 출력
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

# 퍼블릭 서브넷 출력
output "public_subnet" {
  description = "Public subnet ID"
  value       = aws_subnet.public_az1.id
}

# 웹 서버 및 IDS용 프라이빗 서브넷 출력
output "private_web_subnet" {
  description = "Private subnet ID for web servers and IDS"
  value       = aws_subnet.private_web.id
}

# RDS용 프라이빗 서브넷 출력
output "private_rds_subnet" {
  description = "Private subnet ID for RDS"
  value       = aws_subnet.private_rds.id
}

# NAT 인스턴스 출력
output "nat_instance_id" {
  description = "The ID of the NAT instance"
  value       = aws_instance.nat_instance.id
}

output "nat_instance_public_ip" {
  description = "The public IP of the NAT instance"
  value       = aws_instance.nat_instance.public_ip
}

# 라우팅 테이블 출력
output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private.id
}

# 퍼블릭 서브넷 (배열로 반환)
output "public_subnets" {
  description = "List of public subnet IDs"
  value       = [aws_subnet.public_az1.id]  # 퍼블릭 서브넷을 직접 참조
}

# 웹 서버 및 IDS용 프라이빗 서브넷 (배열로 반환)
output "private_web_subnets" {
  description = "List of private subnet IDs for web servers and IDS"
  value       = [aws_subnet.private_web.id]  # 웹 서버 및 IDS 서브넷을 배열로 반환
}

# RDS용 프라이빗 서브넷 (배열로 반환)
output "private_rds_subnets" {
  description = "List of private subnet IDs for RDS"
  value       = [aws_subnet.private_rds.id]  # RDS 서브넷을 배열로 반환
}
