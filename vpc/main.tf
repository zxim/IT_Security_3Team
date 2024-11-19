# VPC 생성
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# 퍼블릭 서브넷 (AZ1)
resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-2a"

  tags = {
    Name = "public-subnet-az1"
  }
}

# 프라이빗 서브넷 (웹 서버 및 IDS용)
resource "aws_subnet" "private_web" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-2a"

  tags = {
    Name = "private-web-subnet"
  }
}

# 프라이빗 서브넷 (RDS용)
resource "aws_subnet" "private_rds" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-2a"

  tags = {
    Name = "private-rds-subnet"
  }
}

# 인터넷 게이트웨이
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "internet-gateway"
  }
}

# 퍼블릭 라우팅 테이블
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# 퍼블릭 서브넷 연결
resource "aws_route_table_association" "public_az1" {
  subnet_id      = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public.id
}

# NAT 인스턴스
resource "aws_instance" "nat_instance" {
  ami           = "ami-040c33c6a51fd5d96" 
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_az1.id
  key_name      = var.ssh_key_name

  tags = {
    Name = "nat-instance"
  }
}

# 프라이빗 라우팅 테이블
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block          = "0.0.0.0/0"
    network_interface_id = aws_instance.nat_instance.primary_network_interface_id
  }

  tags = {
    Name = "private-route-table"
  }
}

# 프라이빗 서브넷 연결 (웹 서버 및 IDS용)
resource "aws_route_table_association" "private_web" {
  subnet_id      = aws_subnet.private_web.id
  route_table_id = aws_route_table.private.id
}

# 프라이빗 서브넷 연결 (RDS용)
resource "aws_route_table_association" "private_rds" {
  subnet_id      = aws_subnet.private_rds.id
  route_table_id = aws_route_table.private.id
}
