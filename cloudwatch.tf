# Monitoring setup (CloudWatch)

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "HighCPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "70"
  alarm_description   = "Alarm when CPU exceeds 70%"

  dimensions = {
    InstanceId        = aws_instance.web-server.id
  }
  alarm_actions       = [aws_sns_topic.my_topic.arn]
}
    
    
# SNS topic for alerts
    resource "aws_sns_topic" "my_topic" {
      name = "my_alerts"
    }
#Subscribe to the SNS topic via email
    resource "aws_sns_topic_subscription" "email_subscription" {
      topic_arn = aws_sns_topic.my_topic.arn
      protocol  = "email"
      endpoint  = "karnam.jaswanth77@gmail.com"
    }
