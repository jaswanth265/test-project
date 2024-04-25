terraform {
  backend "s3" {
    bucket = "access-test-bucketsssssss"
    key    = "value"
    region = "us-west-2"
    dynamodb_table = "terrafrom-state-locking"
    encrypt = true
    #depends_on = aws_s3_bucket.s3_bucket.name
  }
}