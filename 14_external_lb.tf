resource "aws_lb" "pro_external_lb" {
  name="pro-external-lb"
  load_balancer_type = "application"
  internal = false
  subnets= [aws_subnet.weba.id, aws_subnet.webc.id]
  security_groups = [aws_security_group.elb-sg.id]

  tags={
    "Name"= "pro_external_lb"
  }
}

resource "aws_lb_listener" "pro_frontend" {
  load_balancer_arn = aws_lb.pro_external_lb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type="forward"
    target_group_arn=aws_lb_target_group.pro_target.arn
  }
}
resource "aws_lb_target_group" "pro_target" {
  name = "pro-target"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.project_vpc.id

  health_check {
    enabled = true
    healthy_threshold= 3
    interval = 5
    matcher= "200"
    path                = "/index.html"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 2
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group_attachment" "pro_tga_a" {
  target_group_arn = aws_lb_target_group.pro_target.arn
  target_id = aws_instance.web-a.id
  port= 80
}

resource "aws_lb_target_group_attachment" "pro_tga_c" {
  target_group_arn = aws_lb_target_group.pro_target.arn
  target_id = aws_instance.web-c.id
  port= 80
}

output "external_lb_dns_name" {
  value= aws_lb.pro_external_lb.dns_name
}

