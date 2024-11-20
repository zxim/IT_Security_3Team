# Web Server 1 (Primary)

resource "aws_instance" "web1" {
  ami                   = "ami-040c33c6a51fd5d96"  # AWS Ubuntu Free Tier AMI
  instance_type         = var.web_instance_type
  subnet_id             = var.private_web_subnet_az1
  vpc_security_group_ids = [var.security_group_web]

  tags = {
    Name = "${var.environment}-web-server-1"
  }
}

resource "aws_instance" "web2" {
  ami                   = "ami-040c33c6a51fd5d96"  # AWS Ubuntu Free Tier AMI
  instance_type         = var.web_instance_type
  subnet_id             = var.private_web_subnet_az2
  vpc_security_group_ids = [var.security_group_web]

  tags = {
    Name = "${var.environment}-web-server-2"
  }
}

# IDS/IPS Instance
resource "aws_instance" "ids_instance" {
  ami                   = "ami-040c33c6a51fd5d96"  # AWS Ubuntu Free Tier AMI
  instance_type         = "t3.micro"
  key_name              = var.ssh_key_name
  subnet_id             = var.private_web_subnet_az1  # IDS는 AZ1에 배치
  vpc_security_group_ids = [var.security_group_ids]

  tags = {
    Name = "${var.environment}-ids-instance"
  }
}

# NAT Instance
resource "aws_instance" "nat_instance" {
  ami                   = "ami-040c33c6a51fd5d96"  # AWS Ubuntu Free Tier AMI
  instance_type         = "t3.micro"
  key_name              = var.ssh_key_name
  subnet_id     = var.public_subnet[0]
  vpc_security_group_ids = [var.security_group_nat]

  tags = {
    Name = "${var.environment}-nat-instance"
  }
}

# Bastion Host Instance
resource "aws_instance" "bastion" {
  ami                   = "ami-040c33c6a51fd5d96"  # AWS Ubuntu Free Tier AMI
  instance_type         = "t3.micro"
  key_name              = var.ssh_key_name
  subnet_id     = var.public_subnet[0]
  vpc_security_group_ids = [var.security_group_bastion]

  tags = {
    Name = "${var.environment}-bastion-instance"
  }
}
