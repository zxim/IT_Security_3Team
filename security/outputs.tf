# ALB Security Group ID 출력
output "alb_sg" {
  value = aws_security_group.alb.id
}

# 웹 서버 Security Group ID 출력
output "web_sg" {
  value = aws_security_group.web.id
}

# RDS Security Group ID 출력
output "rds_sg" {
  value = aws_security_group.rds.id
}

# 애플리케이션 서버 Security Group ID 출력
output "app_sg" {
  description = "Application security group ID"
  value       = aws_security_group.app.id
}

# 웹 서버에 대한 ALB HTTP 접근을 허용하는 CIDR 블록 출력
output "web_sg_cidr" {
  value = aws_security_group_rule.web_from_alb_http.cidr_blocks
}

# Bastion 보안 그룹 출력
output "bastion_sg" {
  description = "Security Group ID for Bastion Host"
  value       = aws_security_group.bastion.id
}

# WAF ACL ARN 출력
output "waf_acl_arn" {
  description = "ARN of the WAF ACL"
  value       = aws_wafv2_web_acl.waf.arn
}

# WAF와 ALB 연결 출력
output "waf_alb_association" {
  description = "Association of WAF ACL with ALB"
  value       = aws_wafv2_web_acl_association.waf_alb.id
}
