# ALB 생성
resource "aws_lb" "app" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_alb]
  subnets            = var.public_subnets

  tags = {
    Name = "app-load-balancer"
  }
}

# ALB Target Group 설정 (포트 3000 사용)
resource "aws_lb_target_group" "web" {
  name     = "${var.environment}-web-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.environment}-web-tg"
  }
}

# HTTPS 리스너 설정
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.app.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy = "ELBSecurityPolicy-2016-08"

  certificate_arn = var.ssl_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

# 랜덤 ID 생성 (ALB 이름에 접미사로 추가)
resource "random_id" "suffix" {
  byte_length = 4
}

# HTTP 리스너 설정 (HTTPS로 리디렉션)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  # HTTP에서 HTTPS로 리디렉션하는 설정
  default_action {
    type = "redirect"
    redirect {
      protocol   = "HTTPS"
      port       = "443"
      status_code = "HTTP_301"  # Permanent Moved
    }
  }
}

# 리스너 규칙에서 HTTP 리디렉션 설정 (path-pattern 또는 host-header 사용)
resource "aws_lb_listener_rule" "http_redirect" {
  listener_arn = aws_lb_listener.http.arn

  action {
    type = "redirect"
    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"  # Permanent Moved
    }
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  # 조건 없이 모든 HTTP 요청을 HTTPS로 리디렉션
  priority = 100
}

resource "aws_route53_record" "app" {
  zone_id = var.route53_zone_id  # Route 53 Hosted Zone ID
  name    = var.domain_name      # 도메인 이름
  type    = "A"
  alias {
    name                   = aws_lb.app.dns_name
    zone_id                = aws_lb.app.zone_id
    evaluate_target_health = false
  }
}
