# Create Auto Scaling Group
resource "aws_autoscaling_group" "default_asg" {
  name                 = "asg-tf"
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  force_delete         = true
  depends_on           = [aws_lb.alb]
  target_group_arns    = ["${aws_lb_target_group.default-tg.arn}"]
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.webserver-launch-config.name
  vpc_zone_identifier  = var.vpc_zone_identifier_cidrs
  #vpc_zone_identifier  = ["${aws_subnet.public_subnet1.id}", "${aws_subnet.public_subnet2.id}"]

  tag {
    key                 = "Name"
    value               = "Auto-Sacling-Group"
    propagate_at_launch = true
  }
}

# Create Target group

resource "aws_lb_target_group" "default-tg" {
  name       = "TargetGroup"
  depends_on = [aws_vpc.web-vpc]
  port       = 80
  protocol   = "HTTP"
  vpc_id     = aws_vpc.web-vpc.id
  health_check {
    interval            = 70
    path                = "/index.html"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60
    protocol            = "HTTP"
    matcher             = "200,202"
  }
}
