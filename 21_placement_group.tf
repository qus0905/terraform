resource "aws_placement_group" "web_placement" {
  name = "web_placement"
  strategy = "cluster"
  
}

resource "aws_autoscaling_group" "web_auto_group" {
  name = "web_auto_group"
  max_size = 4
  min_size = 1
  health_check_grace_period = 60
  health_check_type = "EC2"
  desired_capacity = 1
  force_delete = false
  launch_configuration = aws_launch_configuration.web_lauch_conf.name
  vpc_zone_identifier = [aws_subnet.weba.id, aws_subnet.webc.id]
}

resource "aws_placement_group" "was_placement" {
  name="was_placement"
  strategy="cluster"
}

resource "aws_autoscaling_group" "was_auto_group" {
  name = "was_auto_group"
  max_size = 4
  min_size = 1
  health_check_grace_period = 60
  health_check_type = "EC2"
  desired_capacity = 1
  force_delete = false
  launch_configuration = aws_launch_configuration.web_lauch_conf.name
  vpc_zone_identifier = [aws_subnet.wasa.id, aws_subnet.wasc.id]
  
}