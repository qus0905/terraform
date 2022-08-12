resource "aws_lb_listener" "pro_frontend" {
  load_balancer_arn = aws_alb.pro_alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type="forward"
    target_group_arn=aws_lb_target_group.pro_target.arn
  }
}