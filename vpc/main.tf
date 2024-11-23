# VPC 생성
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment}-vpc"
  }
}

# 기존 인터넷 게이트웨이 확인
data "aws_internet_gateway" "existing" {
  filter {
    name   = "attachment.vpc-id"
    values = [aws_vpc.main.id]
  }
}

# 인터넷 게이트웨이 (조건부 생성)
resource "aws_internet_gateway" "main" {
  # count = length(data.aws_internet_gateway.existing.id) == 0 ? 1 : 0
  count = 1
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-igw"
  }
}

# 퍼블릭 서브넷 (AZ1)
resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_az1
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-2a"

  tags = {
    Name = "Web Subnet"
  }
}

# 퍼블릭 서브넷 (AZ2)
resource "aws_subnet" "public_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_az2
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-2c"

  tags = {
    Name = "Web Subnet"
  }
}

# 프라이빗 서브넷 (애플리케이션 AZ1)
resource "aws_subnet" "private_app_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_web_subnet_cidr_az1
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-2a"

  tags = {
    Name = "App Subnet"
  }
}

# 프라이빗 서브넷 (애플리케이션 AZ2)
resource "aws_subnet" "private_app_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_web_subnet_cidr_az2
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-2c"

  tags = {
    Name = "${var.environment}-private-app-az2"
  }
}

# 프라이빗 서브넷 (RDS AZ1)
resource "aws_subnet" "private_rds_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_rds_subnet_cidr_az1
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-2a"

  tags = {
    Name = "RDS Subnet AZ1"
  }
}

# 프라이빗 서브넷 (RDS AZ2)
resource "aws_subnet" "private_rds_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_rds_subnet_cidr_az2
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-2c"

  tags = {
    Name = "RDS Subnet AZ2"
  }
}

# 퍼블릭 라우팅 테이블
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-public-rt"
  }
}

# 퍼블릭 라우팅 테이블과 IGW 연결
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = length(data.aws_internet_gateway.existing.id) > 0 ? data.aws_internet_gateway.existing.id : aws_internet_gateway.main[0].id
}

# 퍼블릭 서브넷과 라우팅 테이블 연결
resource "aws_route_table_association" "public_az1" {
  subnet_id      = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_az2" {
  subnet_id      = aws_subnet.public_az2.id
  route_table_id = aws_route_table.public.id
}

# NAT 게이트웨이용 Elastic IP 생성
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.environment}-nat-eip"
  }
}

# NAT 게이트웨이
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_az1.id

  tags = {
    Name = "${var.environment}-nat-gateway"
  }
}

# 프라이빗 라우팅 테이블
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-private-rt"
  }
}

# 프라이빗 서브넷과 NAT 연결
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

# 프라이빗 서브넷과 라우팅 테이블 연결
resource "aws_route_table_association" "private_app_az1" {
  subnet_id      = aws_subnet.private_app_az1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_app_az2" {
  subnet_id      = aws_subnet.private_app_az2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_rds_az1" {
  subnet_id      = aws_subnet.private_rds_az1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_rds_az2" {
  subnet_id      = aws_subnet.private_rds_az2.id
  route_table_id = aws_route_table.private.id
}
