# ALB 출력값 정의

output "alb_dns_name" {
  description = "ALB의 DNS 이름"
  value       = aws_alb.app.dns_name
}
