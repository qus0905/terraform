resource "aws_route_table" "pub_table" {
  vpc_id = aws_vpc.project_vpc.id
  

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pro_ig.id
  }

  tags = {
    "Name" = "pub_table"
  }
}

resource "aws_route_table_association" "pub_1" {
  subnet_id = aws_subnet.weba.id
  route_table_id = aws_route_table.pub_table.id
}

resource "aws_route_table_association" "pub_2" {
  subnet_id = aws_subnet.webc.id
  route_table_id = aws_route_table.pub_table.id 
}