output "waf_acl_arn" {
  description = "The ARN of the WAF ACL"
  value       = aws_wafv2_web_acl.waf.arn
}

output "waf_alb_association_id" {
  description = "The ID of the WAF association with ALB"
  value       = aws_wafv2_web_acl_association.waf_alb.id
}
