output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_az1_id" {
  value = aws_subnet.public_az1.id
}

output "public_subnet_az2_id" {
  value = aws_subnet.public_az2.id
}

output "private_web_subnet_az1_id" {
  value = aws_subnet.private_app_az1.id
}

output "private_web_subnet_az2_id" {
  value = aws_subnet.private_app_az2.id
}

output "private_rds_subnet_az1_id" {
  value = aws_subnet.private_rds_az1.id
}

output "private_rds_subnet_az2_id" {
  value = aws_subnet.private_rds_az2.id
}

output "private_web_subnet_ids" {
  description = "List of private web subnet IDs"
  value       = [
    aws_subnet.private_app_az1.id, aws_subnet.private_app_az2.id
  ]
}

# 퍼블릭 서브넷 AZ1 ID 출력
output "public_subnet_cidr_az1" {
  description = "Public subnet AZ1 ID"
  value       = aws_subnet.public_az1.id
}

# 퍼블릭 서브넷 AZ2 ID 출력
output "public_subnet_cidr_az2" {
  description = "Public subnet AZ2 ID"
  value       = aws_subnet.public_az2.id
}

# 프라이빗 애플리케이션 서브넷 출력
output "private_web_subnet_cidr_az1" {
  description = "Private web subnet AZ1 ID"
  value       = aws_subnet.private_app_az1.id
}

output "private_web_subnet_cidr_az2" {
  description = "Private web subnet AZ2 ID"
  value       = aws_subnet.private_app_az2.id
}

# Route 53 Hosted Zone ID 출력
output "route53_zone_id" {
  description = "The ID of the Route 53 Hosted Zone"
  value       = aws_route53_zone.main.zone_id
}

# Route 53 A 레코드 이름 출력
output "route53_record_name" {
  description = "The name of the Route 53 A Record"
  value       = aws_route53_record.www.name
}

# Route 53 A 레코드 도메인 출력
output "route53_record_domain" {
  description = "The full domain name for the A Record"
  value       = "${aws_route53_record.www.name}.${aws_route53_zone.main.name}"
}
