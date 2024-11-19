# Web Instance
resource "aws_instance" "web" {
  ami                   = "ami-040c33c6a51fd5d96"
  instance_type         = var.web_instance_type
  key_name              = var.ssh_key_name
  subnet_id             = var.private_web_subnet      # private_web_subnet 변수를 사용
  vpc_security_group_ids = [var.security_group_web]

  tags = {
    Name = "${var.environment}-web-instance"
  }
}

# NAT Instance
resource "aws_instance" "nat_instance" {
  ami                   = "ami-040c33c6a51fd5d96"  # 우분투 프리티어 이미지
  instance_type         = "t3.micro"
  key_name              = var.ssh_key_name
  subnet_id             = var.public_subnet          # public_subnet 변수를 사용
  vpc_security_group_ids = [var.security_group_nat]

  tags = {
    Name = "${var.environment}-nat-instance"
  }
}

# Bastion Host Instance
resource "aws_instance" "bastion" {
  ami                   = "ami-040c33c6a51fd5d96"  # 우분투 프리티어 이미지
  instance_type         = "t3.micro"
  key_name              = var.ssh_key_name
  subnet_id             = var.public_subnet          # public_subnet 변수를 사용
  vpc_security_group_ids = [var.security_group_bastion]

  tags = {
    Name = "${var.environment}-bastion-instance"
  }
}

# IDS Instance
resource "aws_instance" "ids_instance" {
  ami                   = "ami-040c33c6a51fd5d96"
  instance_type         = "t3.micro"
  key_name              = var.ssh_key_name
  subnet_id             = var.private_web_subnet      # private_web_subnet 변수를 사용
  vpc_security_group_ids = [var.security_group_ids]

  tags = {
    Name = "${var.environment}-ids-instance"
  }
}
