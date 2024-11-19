# ALB 생성
resource "aws_alb" "app" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_alb]
  subnets            = var.public_subnets

  tags = {
    Name = "app-load-balancer"
  }
}

# ALB 대상 그룹 (IDS/IPS 대상)
resource "aws_alb_target_group" "ids" {
  name     = "ids-target-group-${random_id.suffix.hex}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "IDS-Target-Group"
  }
}

# ALB 대상 그룹 (웹 서버 대상)
resource "aws_alb_target_group" "web" {
  name     = "web-target-group-${random_id.suffix.hex}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "Web-Target-Group"
  }
}

# ALB 리스너 (IDS/IPS로 트래픽 전달)
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ids.arn
  }
}

# IDS/IPS 대상 그룹에서 웹 서버 대상으로 트래픽 전달
resource "aws_lb_listener_rule" "ids_to_web" {
  listener_arn = aws_alb_listener.http.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.web.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}
