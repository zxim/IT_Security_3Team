resource "aws_guardduty_detector" "main" {
  enable = true
}

resource "aws_securityhub_account" "main" {
  enable_default_standards = true
}

resource "aws_securityhub_product_subscription" "guardduty" {
  depends_on  = [aws_securityhub_account.main]
  product_arn = "arn:aws:securityhub:${var.aws_region}::product/aws/guardduty"
}

resource "aws_cloudwatch_log_group" "security_logs" {
  name = "/aws/security/logs"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_metric_filter" "guardduty_finding" {
  name           = "GuardDutyFinding"
  pattern        = "{ $.detail-type = \"GuardDuty Finding\" }"
  log_group_name = aws_cloudwatch_log_group.security_logs.name

  metric_transformation {
    name      = "GuardDutyFindingCount"
    namespace = "SecurityMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "guardduty_finding_alarm" {
  alarm_name          = "GuardDutyFindingAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "GuardDutyFindingCount"
  namespace           = "SecurityMetrics"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "This alarm triggers when GuardDuty detects a finding"
  alarm_actions       = [aws_sns_topic.security_alerts.arn]
}

resource "aws_sns_topic" "security_alerts" {
  name = "security-alerts"
}