resource "aws_autoscaling_attachment" "web_auto" {
  autoscaling_group_name = aws_autoscaling_group.web_auto_group.name
  lb_target_group_arn = aws_lb_target_group.pro_target.arn
}

resource "aws_autoscaling_attachment" "was_auto" {
  autoscaling_group_name = aws_autoscaling_group.was_auto_group.name
  lb_target_group_arn = aws_lb_target_group.nlb_target.arn
}