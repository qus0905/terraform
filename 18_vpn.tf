
resource "aws_vpn_gateway" "pro_vpc_gateway" {
  vpc_id = aws_vpc.project_vpc.id

  tags = {
    "Name" = "pro-vpc-gateway"
  }
}

resource "aws_customer_gateway" "cus_ga" {
  bgp_asn = 65000
  ip_address = "${data.http.ip.body}"
  type       = "ipsec.1"

  tags = {
    "Name" = "pro-cus-ga"
  }
}

resource "aws_vpn_connection" "pro-vpn-conn" {
  vpn_gateway_id = aws_vpn_gateway.pro_vpc_gateway.id
  customer_gateway_id = aws_customer_gateway.cus_ga.id
  type = "ipsec.1"
   static_routes_only  = true
  tags = {
    "Name" = "pro-vpn-conn"
  }
}
resource "aws_vpn_connection_route" "untnagle" {
  destination_cidr_block = "3.0.0.0/24"
  vpn_connection_id = aws_vpn_connection.pro-vpn-conn.id
}