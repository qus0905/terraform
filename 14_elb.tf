resource "aws_alb" "pro_alb" {
  name="pro-alb"
  internal = false
  subnets= [aws_subnet.weba.id, aws_subnet.webc.id]
  security_groups = [aws_security_group.pro_sec.id]

  tags={
    "Name"= "pro_alb"
  }
}

output "dns_name" {
  value= aws_alb.pro_alb.dns_name
}