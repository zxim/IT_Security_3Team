# Bastion Host (AZ1 - Public Subnet)
resource "aws_instance" "bastion" {
  ami                   = "ami-040c33c6a51fd5d96"
  instance_type         = var.web_instance_type
  subnet_id             = var.public_subnet[0] # AZ1 Public Subnet
  vpc_security_group_ids = [var.security_group_bastion]
  key_name              = var.ssh_key_name_bastion

  tags = {
    Name = "${var.environment}-bastion-instance"
  }
}

# Web Server Instances
resource "aws_instance" "web1" {
  ami                   = "ami-040c33c6a51fd5d96"
  instance_type         = var.web_instance_type
  subnet_id             = var.public_subnet[0]
  key_name              = var.ssh_key_name_web
  vpc_security_group_ids = [var.security_group_web]
  tags = {
    Name = "${var.environment}-web1"
  }
}

resource "aws_instance" "web2" {
  ami                   = "ami-040c33c6a51fd5d96"
  instance_type         = var.web_instance_type
  subnet_id             = var.public_subnet[1]
  key_name              = var.ssh_key_name_web
  vpc_security_group_ids = [var.security_group_web]
  tags = {
    Name = "${var.environment}-web2"
  }
}

# Application Server 1 (AZ1 - Private Subnet)
resource "aws_instance" "app1" {
  ami                   = "ami-040c33c6a51fd5d96"
  instance_type         = var.web_instance_type
  key_name              = var.ssh_key_name_app
  subnet_id             = var.private_web_subnet_az1 # AZ1 Private Subnet
  vpc_security_group_ids = [var.security_group_app]

  tags = {
    Name = "${var.environment}-app-server-1"
  }
}

# Application Server 2 (AZ2 - Private Subnet)
resource "aws_instance" "app2" {
  ami                   = "ami-040c33c6a51fd5d96"
  instance_type         = var.web_instance_type
  key_name              = var.ssh_key_name_app
  subnet_id             = var.private_web_subnet_az2 # AZ2 Private Subnet
  vpc_security_group_ids = [var.security_group_app]

  tags = {
    Name = "${var.environment}-app-server-2"
  }
}
