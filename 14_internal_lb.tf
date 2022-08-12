resource "aws_lb" "pro_internal_lb" {
  name="pro-internal-lb"
  internal = true
  subnets= [aws_subnet.wasa.id, aws_subnet.wasc.id]
  security_groups = [aws_security_group.nlb-sg.id]
  load_balancer_type = "application"

  tags={
    "Name"= "pro-internal-lb"
  }
}

resource "aws_lb_target_group" "nlb_target" {
  name = "pro-nlb-target"
  port = 8080
  protocol = "HTTP"
  vpc_id = aws_vpc.project_vpc.id
  target_type = "instance"
  
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

  tags = {
    "Name" = "nlb-target"
  }
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.pro_internal_lb.arn
  port = 8080
  protocol = "HTTP"

  default_action {
    type="forward"
    target_group_arn=aws_lb_target_group.nlb_target.arn
  }


}

resource "aws_lb_target_group_attachment" "nlb-tga-a" {
  target_group_arn = aws_lb_target_group.nlb_target.arn
  target_id = aws_instance.was-a.id
  port=8080
}

resource "aws_lb_target_group_attachment" "nlb-tga-c" {
  target_group_arn = aws_lb_target_group.nlb_target.arn
  target_id = aws_instance.was-c.id
  port=8080
}

output "internal_lb_dns_name" {
    value= aws_lb.pro_internal_lb.dns_name
}