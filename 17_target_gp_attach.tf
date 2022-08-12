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
