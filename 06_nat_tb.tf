resource "aws_route_table" "nat_table" {
  vpc_id = aws_vpc.project_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.pro_ng.id
  }

  route{
    cidr_block = "3.0.0.0/24"
    gateway_id = aws_vpn_gateway.pro_vpn_gateway.id
   }

  tags = {
    "Name" = "Nat-table"
  }
}
resource "aws_route_table_association" "route_web_a" {
  subnet_id = aws_subnet.weba.id
  route_table_id = aws_route_table.nat_table.id
}

resource "aws_route_table_association" "route_web_c" {
  subnet_id = aws_subnet.webc.id
  route_table_id = aws_route_table.nat_table.id
}

resource "aws_route_table_association" "route_was_a" {
  subnet_id = aws_subnet.wasa.id
  route_table_id = aws_route_table.nat_table.id
}
resource "aws_route_table_association" "route_was_c" {
  subnet_id = aws_subnet.wasc.id
  route_table_id = aws_route_table.nat_table.id
}

resource "aws_route_table_association" "route_db_a" {
  subnet_id = aws_subnet.dba.id
  route_table_id = aws_route_table.nat_table.id
}

resource "aws_route_table_association" "route_db_c" {
  subnet_id = aws_subnet.dbc.id
  route_table_id =aws_route_table.nat_table.id
}
