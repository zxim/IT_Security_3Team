# Route 53 Hosted Zone 생성 (도메인 등록이 이미 되어 있을 경우 Hosted Zone만 생성)
resource "aws_route53_zone" "main" {
  name = var.route53_domain_name
}

# ALB와 연결된 A 레코드 생성
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${var.route53_domain_name}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
