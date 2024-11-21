# ALB 출력값 정의

output "alb_dns_name" {
  description = "ALB의 DNS 이름"
  value       = aws_alb.app.dns_name
}

output "web_target_group_arn" {
  description = "ARN of the Web Target Group"
  value       = aws_lb_target_group.web.arn
}

output "alb_arn" {
  description = "ALB의 ARN"
  value       = aws_alb.app.arn
}

output "alb_https_listener_arn" {
  description = "ALB HTTPS 리스너의 ARN"
  value       = aws_alb_listener.https.arn
}

output "alb_security_group_id" {
  description = "ALB에 적용된 Security Group ID"
  value       = var.security_group_alb
}
