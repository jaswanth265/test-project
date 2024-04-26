#Create Launch config

resource "aws_launch_configuration" "webserver-launch-config" {
  name_prefix     = "webserver-launch-config"
  image_id        = var.ami_id
  instance_type   = "t2.micro"
  key_name        = var.key_pair
  security_groups = ["${aws_security_group.web_sg.id}"]
  iam_instance_profile = [aws_iam_instance_profile.ec2_profile,
    aws_iam_instance_profile.s3_backend_instance_profile,
  aws_iam_instance_profile.asg_profile]

  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    encrypted   = true
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = 5
    encrypted   = true
  }


  lifecycle {
    create_before_destroy = true
  }
  user_data = filebase64("${path.module}/webserver.sh")
}
