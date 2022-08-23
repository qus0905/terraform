resource "aws_internet_gateway" "pro_ig" {
  vpc_id = aws_vpc.project_vpc.id
  tags ={
    "Name"= "pro-int-gw"
  }
}

resource "aws_eip" "pro_eip" {
  vpc = true
  tags = {
    "Name" = "pro-eip"
  }
}

resource "aws_nat_gateway" "pro_ng" {
  allocation_id = aws_eip.pro_eip.id
  subnet_id = aws_subnet.public_sub.id

  tags = {
    "Name" = "pro-nat-gw"
  }

  depends_on = [
    aws_internet_gateway.pro_ig
  ]
}