resource "aws_wafv2_web_acl" "example" {
  name        = "dev-web-acl"
  scope       = "REGIONAL"  # Use REGIONAL for ALB integration

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "example-metric"
    sampled_requests_enabled   = true
  }

  # Adding a rule to block malicious user-agents
  rule {
    name     = "example-rule"
    priority = 1
    action {
      allow {}
    }
    statement {
      byte_match_statement {
        field_to_match {
          single_header {
            name = "user-agent"
          }
        }
        positional_constraint = "CONTAINS"
        search_string         = "BadBot"
        text_transformation {
          type     = "NONE"
          priority = 0
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "example-rule-metric"
      sampled_requests_enabled   = true
    }
  }
}

# Associate WAF Web ACL with the ALB
resource "aws_wafv2_web_acl_association" "example" {
  resource_arn = var.alb_arn  # ALB ARN passed as variable
  web_acl_arn  = aws_wafv2_web_acl.example.arn
}
