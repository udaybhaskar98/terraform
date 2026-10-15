terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.68.0"
    }
  }

#   backend "s3" {

#     bucket = "remote-state-file-buk3t"
#     key = "terraform.tfstate"
#     region = "ap-south-1"
#     dynamodb_table = "ts-state-lock-table"
# }

}

