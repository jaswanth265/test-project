# resource "aws_s3_bucket" "s3_bucket"{
#     bucket = "aws-s3-backend-terraform"
#     acl = "private"
#     lifecycle {
#       prevent_destroy = true
#     }
#     versioning {
#       enabled = true
#     }
# }

# resource "aws_dynamodb_table" "terraform-locks" {
#   name           = "terrafrom-state-locking"
#   billing_mode   = "PROVISIONED"
#   read_capacity  = 20
#   write_capacity = 20
#   hash_key       = "LockID"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

