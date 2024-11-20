# VPC ID 출력
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

# 퍼블릭 서브넷 출력 (개별적으로 출력)
output "public_subnet_az1_id" {
  description = "The ID of public subnet in AZ1"
  value       = aws_subnet.public_az1.id
}

output "public_subnet_az2_id" {
  description = "The ID of public subnet in AZ2"
  value       = aws_subnet.public_az2.id
}

# 웹 서버 및 IDS용 프라이빗 서브넷 출력 (개별적으로 출력)
output "private_web_subnet_az1_id" {
  description = "The ID of private web subnet in AZ1"
  value       = aws_subnet.private_web_az1.id
}

output "private_web_subnet_az2_id" {
  description = "The ID of private web subnet in AZ2"
  value       = aws_subnet.private_web_az2.id
}

# RDS용 프라이빗 서브넷 출력 (개별적으로 출력)
output "private_rds_subnet_az1_id" {
  description = "The ID of private RDS subnet in AZ1"
  value       = aws_subnet.private_rds_az1.id
}

output "private_rds_subnet_az2_id" {
  description = "The ID of private RDS subnet in AZ2"
  value       = aws_subnet.private_rds_az2.id
}
