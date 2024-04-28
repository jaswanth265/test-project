terraform {
  backend "s3" {
    bucket = "aws-s3-backend-terraform"
    key    = "value"
    region = "us-west-2"
  }
}
