# terraform {
#   backend "s3" {
#     bucket         = "s3-bucket-name"
#     key            = "path/to/terraform.tfstate"
#     region         = var.region
#     dynamodb_table = "dynamodb-table-name"
#   }
# }
