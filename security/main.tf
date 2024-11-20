# ALB Security Group
resource "aws_security_group" "alb" {
  name        = "${var.environment}-alb-sg"
  description = "Allow HTTP and HTTPS traffic to ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP traffic from anywhere
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTPS traffic from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-alb-sg"
  }
}

# Web Security Group
resource "aws_security_group" "web" {
  name        = "${var.environment}-web-sg"
  description = "Allow traffic to web servers"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-web-sg"
  }
}

resource "aws_security_group_rule" "web_from_alb_http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web.id
  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "web_from_alb_https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web.id
  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "web_from_ids" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web.id
  source_security_group_id = aws_security_group.ids.id

  description = "Allow HTTP traffic from IDS/IPS to Web Servers"
}

# Bastion Security Group
resource "aws_security_group" "bastion" {
  name        = "${var.environment}-bastion-sg"
  description = "Allow SSH traffic to Bastion Host"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-bastion-sg"
  }
}

# RDS Security Group
resource "aws_security_group" "rds" {
  name        = "${var.environment}-rds-sg"
  description = "Allow MySQL traffic to RDS"
  vpc_id      = var.vpc_id

  # MySQL 접근 허용: 웹 서버 1
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${var.web1_private_ip}/32"]
  }

  # MySQL 접근 허용: 웹 서버 2
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${var.web2_private_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-rds-sg"
  }
}


resource "aws_security_group_rule" "rds_from_web" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds.id
  source_security_group_id = aws_security_group.web.id

  description = "Allow MySQL traffic from Web Servers"
}

# IDS Security Group
resource "aws_security_group" "ids" {
  name        = "${var.environment}-ids-sg"
  description = "Allow traffic to IDS/IPS"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-ids-sg"
  }
}

resource "aws_security_group_rule" "ids_from_alb_http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ids.id
  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "ids_from_alb_https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ids.id
  source_security_group_id = aws_security_group.alb.id
}

# NAT Security Group
resource "aws_security_group" "nat" {
  name        = "${var.environment}-nat-sg"
  description = "Allow all traffic through NAT"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-nat-sg"
  }
}
