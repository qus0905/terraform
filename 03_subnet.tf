resource "aws_subnet" "public_sub" {
  vpc_id = aws_vpc.project_vpc.id
 cidr_block = "12.0.0.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags={
    "Name" = "public_sub1"
  }
}

resource "aws_subnet" "public_sub2" {
  vpc_id = aws_vpc.project_vpc.id
 cidr_block = "12.0.1.0/24"
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = true
  tags={
    "Name" = "public_sub2"
  }
}

resource "aws_subnet" "weba" {
  vpc_id= aws_vpc.project_vpc.id
  cidr_block = "12.0.2.0/24"
  availability_zone = "ap-northeast-2a"
  tags={
    "Name" = "pj-web-a"
  }
}
resource "aws_subnet" "webc" {
  vpc_id= aws_vpc.project_vpc.id
  cidr_block = "12.0.3.0/24"
  availability_zone = "ap-northeast-2c"
  tags={
    "Name" = "pj-web-c"
  }
}
resource "aws_subnet" "wasa" {
  vpc_id= aws_vpc.project_vpc.id
  cidr_block = "12.0.4.0/24"
  availability_zone = "ap-northeast-2a"
  tags={
    "Name" = "pj-was-a"
  }
}
resource "aws_subnet" "wasc" {
  vpc_id= aws_vpc.project_vpc.id
  cidr_block = "12.0.5.0/24"
  availability_zone = "ap-northeast-2c"
  tags={
    "Name" = "pj-was-c"
  }
}
resource "aws_subnet" "dba" {
  vpc_id= aws_vpc.project_vpc.id
  cidr_block = "12.0.6.0/24"
  availability_zone = "ap-northeast-2a"
  tags={
    "Name" = "pj-db-a"
  }
}
resource "aws_subnet" "dbc" {
  vpc_id= aws_vpc.project_vpc.id
  cidr_block = "12.0.7.0/24"
  availability_zone = "ap-northeast-2c"
  tags={
    "Name" = "pj-db-c"
  }
}
