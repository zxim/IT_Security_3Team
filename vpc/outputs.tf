# VPC 관련 출력값 정의

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = [aws_subnet.public_az1.id, aws_subnet.public_az2.id]
}

output "private_web_subnets" {
  value = [aws_subnet.private_az1.id, aws_subnet.private_az2.id]
}

output "private_rds_subnets" {
  value = [aws_subnet.private_rds_az1.id, aws_subnet.private_rds_az2.id]
}

