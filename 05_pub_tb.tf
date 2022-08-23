resource "aws_route_table" "pub_table" {
  vpc_id = aws_vpc.project_vpc.id
  

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pro_ig.id
  }
   
   route{
    cidr_block = "3.0.0.0/24"
    gateway_id = aws_vpn_gateway.pro_vpn_gateway.id
   }
   
  tags = {
    "Name" = "pub_table"
  }
}
resource "aws_route_table_association" "public_route_1" {
  subnet_id = aws_subnet.public_sub.id
  route_table_id = aws_route_table.pub_table.id
}
resource "aws_route_table_association" "public_route_2" {
  subnet_id = aws_subnet.public_sub2.id
  route_table_id = aws_route_table.pub_table.id
}