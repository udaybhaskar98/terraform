# resource "aws_s3_bucket" "bucket_res" {
#   bucket = "demo-buck3t-tf2"
# }

# import {
#   to = aws_s3_bucket.bucket_res

#   identity = {
#     bucket = "demo-buck3t-tf2"
#   }
# }

# or terraform import aws_s3_bucket.bucket_res demo-buck3t-tf2