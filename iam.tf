# EC2

resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2_policy"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_role.name
}


#S3 Backend

# IAM Policy
resource "aws_iam_role_policy" "s3_backend_policy" {
  name = "S3BackendPolicy"
  role = aws_iam_role.s3_backend_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListObject",
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::aws-s3-backend-terraform/*"  
    }
  ]
}
EOF
}

# IAM Role
resource "aws_iam_role" "s3_backend_role" {
  name = "S3BackendRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "s3_backend_instance_profile" {
  name = "S3BackendInstanceProfile"
  role = aws_iam_role.s3_backend_role.name
}

# END



# Autoscaling 

resource "aws_iam_role_policy" "asg_policy" {
  name = "asg_policy"
  role = aws_iam_role.asg_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "autoscaling:Describe*",
          "autoscaling:CreateAutoScalingGroup",
          "autoscaling:UpdateAutoScalingGroup",
          "autoscaling:DeleteAutoScalingGroup",
          "autoscaling:CreateLaunchConfiguration",
          "autoscaling:DeleteLaunchConfiguration",
          "autoscaling:AttachLoadBalancerTargetGroups",
          "autoscaling:DetachLoadBalancerTargetGroups",
          "autoscaling:PutScalingPolicy",
          "autoscaling:DeletePolicy",
          "autoscaling:UpdateAutoScalingGroup",
          "autoscaling:PutScheduledUpdateGroupAction",
          "ec2:Describe*",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:RevokeSecurityGroupEgress",
          "ec2:CreateSecurityGroup",
          "ec2:DeleteSecurityGroup",
          "ec2:CreateTags",
          "ec2:ModifyInstanceAttribute",
          "elasticloadbalancing:Describe*",
          "elasticloadbalancing:CreateLoadBalancer",
          "elasticloadbalancing:DeleteLoadBalancer",
          "elasticloadbalancing:ModifyLoadBalancerAttributes",
          "elasticloadbalancing:RegisterTargets",
          "elasticloadbalancing:DeregisterTargets",
          "elasticloadbalancing:CreateTargetGroup",
          "elasticloadbalancing:DeleteTargetGroup",
          "iam:PassRole"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "asg_role" {
  name = "asg_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "autoscaling.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "asg_profile" {
  name = "asg_profile"
  role = aws_iam_role.asg_role.name
}
