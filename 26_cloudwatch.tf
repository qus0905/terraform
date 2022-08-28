resource "aws_sns_topic" "pro-sns" {
  name = "pro-sns"
}

resource "aws_sns_topic_subscription" "email-target1" {
  topic_arn = aws_sns_topic.pro-sns.arn
  protocol = "email"
  endpoint = "qus0905@naver.com"
}



resource "aws_cloudwatch_metric_alarm" "elb_502" {
  alarm_name = "elb-alarm"
   comparison_operator = "GreaterThanOrEqualToThreshold"
   metric_name = "UnHealthyHostCount"
   namespace = "AWS/ApplicationELB"
   evaluation_periods        = "1"
   period                    = "60"
   statistic                 = "Average"
   threshold                 = "1"
   alarm_description         = "This metric monitors ELB's UnHealthyHostCount"
   actions_enabled = true
   alarm_actions=[aws_sns_topic.pro-sns.arn]
   insufficient_data_actions = []

   dimensions = {
     LoadBalancer = "${aws_lb.pro_external_lb.arn_suffix}"
     TargetGroup="${aws_lb_target_group.pro_target.arn_suffix}"
   }
}