# resource "aws_instance" "web-server" {
#   ami                         = var.image_name
#   availability_zone           = var.availability_zone
#   instance_type               = var.instance_type
#   key_name                    = var.key_name
#   subnet_id                   = "{aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id }"
#   vpc_security_group_ids      = ["${aws_security_group.web_sg.id}"]
#   iam_instance_profile        = aws_iam_instance_profile.s3-mybucket-role-instanceprofile.name
#   associate_public_ip_address = true
#   tags = {
#     Name = "Web-Server"
#     Env  = "prod"
#   }
# }
