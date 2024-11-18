# VPC 생성
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
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

# 퍼블릭 서브넷 (AZ2)
resource "aws_subnet" "public_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-2c"
  tags = {
    Name = "public-subnet-az2"
  }
}

# 프라이빗 서브넷 (AZ1)
resource "aws_subnet" "private_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-2a"
  tags = {
    Name = "private-subnet-az1"
  }
}

# 프라이빗 서브넷 (AZ2)
resource "aws_subnet" "private_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-2c"
  tags = {
    Name = "private-subnet-az2"
  }
}

# 프라이빗 서브넷 (RDS용, AZ1)
resource "aws_subnet" "private_rds_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.5.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-2a"
  tags = {
    Name = "private-rds-subnet-az1"
  }
}

# 프라이빗 서브넷 (RDS용, AZ2)
resource "aws_subnet" "private_rds_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.6.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-2c"
  tags = {
    Name = "private-rds-subnet-az2"
  }
}

# 인터넷 게이트웨이
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "internet-gateway"
  }
}

# NAT 게이트웨이
resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_az1.id # NAT 게이트웨이는 퍼블릭 서브넷에 연결
  tags = {
    Name = "nat-gateway"
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

resource "aws_route_table_association" "public_az2" {
  subnet_id      = aws_subnet.public_az2.id
  route_table_id = aws_route_table.public.id
}

# 프라이빗 라우팅 테이블
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-route-table"
  }
}

# 프라이빗 서브넷 연결 (웹 서버용)
resource "aws_route_table_association" "private_web_az1" {
  subnet_id      = aws_subnet.private_az1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_web_az2" {
  subnet_id      = aws_subnet.private_az2.id
  route_table_id = aws_route_table.private.id
}

# 프라이빗 서브넷 연결 (RDS용)
resource "aws_route_table_association" "private_rds_az1" {
  subnet_id      = aws_subnet.private_rds_az1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_rds_az2" {
  subnet_id      = aws_subnet.private_rds_az2.id
  route_table_id = aws_route_table.private.id
}
