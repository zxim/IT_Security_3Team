# compute/main.tf

resource "aws_instance" "web" {
  count         = length(var.private_web_subnets)
  ami           = "ami-040c33c6a51fd5d96"
  instance_type = "t2.micro"
  subnet_id     = var.private_web_subnets[count.index]
  security_groups = [var.security_group_web]

  tags = {
    Name = "web-instance-${count.index}"
  }
}

resource "aws_instance" "bastion" {
  ami           = "ami-040c33c6a51fd5d96"
  instance_type = "t2.micro"
  subnet_id     = var.public_subnets[0]
  security_groups = [var.security_group_bastion]

  tags = {
    Name = "bastion-host"
  }
}

resource "aws_instance" "ids_instance" {
  ami           = "ami-040c33c6a51fd5d96" # Ubuntu Free-tier AMI
  instance_type = "t2.micro"
  subnet_id     = var.private_web_subnets[0] # IDS/IPS를 Private Subnet 1에 배치
   vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "IDS-IPS-Instance"
  }
}
