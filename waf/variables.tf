# WAF ACL 이름
variable "waf_acl_name" {
  description = "Name of the WAF ACL"
  type        = string
  default     = "default-waf-acl"
}

# WAF ACL Metric 이름
variable "waf_acl_metric_name" {
  description = "Metric name for WAF ACL"
  type        = string
  default     = "web-acl-metrics"
}

# ALB ARN
variable "alb_arn" {
  description = "The ARN of the ALB to associate with WAF"
  type        = string
}
