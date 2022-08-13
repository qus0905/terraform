resource "aws_placement_group" "web_placement" {
  name="web_placement"
  strategy="cluster"
}

resource "aws_autoscaling_group" "web_auto_group" {
  name = "web_auto_group"
  max_size = 4
  min_size = 1
  health_check_grace_period = 60
  health_check_type = "ELB"
  desired_capacity = 1
  force_delete = false
  launch_configuration = aws_launch_configuration.web_launch_conf.name
  vpc_zone_identifier = [aws_subnet.weba.id, aws_subnet.webc.id]
}

resource "aws_autoscaling_policy" "web-tracking" {

  name="web-tracking"
  policy_type = "TargetTrackingScaling"
  estimated_instance_warmup = 60
  autoscaling_group_name = aws_autoscaling_group.web_auto_group.name

  target_tracking_configuration {
    predefined_metric_specification{
      predefined_metric_type="ASGAverageCPUUtilization"
    }

    target_value=40.0
  }
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
  health_check_type = "ELB"
  desired_capacity = 1
  force_delete = false
  launch_configuration = aws_launch_configuration.was_launch_conf.name
  vpc_zone_identifier = [aws_subnet.wasa.id, aws_subnet.wasc.id]
  
}

resource "aws_autoscaling_policy" "was-tracking" {

  name="was-tracking"
  policy_type = "TargetTrackingScaling"
  estimated_instance_warmup = 60
  autoscaling_group_name = aws_autoscaling_group.was_auto_group.name

  target_tracking_configuration {
    predefined_metric_specification{
      predefined_metric_type="ASGAverageCPUUtilization"
    }

    target_value=40.0
  }
}