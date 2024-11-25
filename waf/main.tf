# WAF ACL 생성
resource "aws_wafv2_web_acl" "waf" {
  name  = var.waf_acl_name
  scope = "REGIONAL" # ALB와 연계. CloudFront 연계 시 "CLOUDFRONT" 설정.

  default_action {
    allow {} # 기본 동작
  }

  # 관리형 규칙 추가
  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }
    override_action {
      none {}
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "commonRuleSet"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = var.waf_acl_metric_name
    sampled_requests_enabled   = true
  }
}

# WAF와 ALB 연결
resource "aws_wafv2_web_acl_association" "waf_alb" {
  resource_arn = var.alb_arn # ALB ARN과 연계
  web_acl_arn  = aws_wafv2_web_acl.waf.arn
}
