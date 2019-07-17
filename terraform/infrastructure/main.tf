terraform {
  backend "s3" {
    bucket = "brewjacket-terraform-state"
    key = "infrastructure/terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "terraform-state-locks"
  }
}

provider "aws" { region = "us-west-2" }

resource "aws_dynamodb_table" "dynamodb-terraform-lock" {
  name = "terraform-state-locks"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "terraform_state_storage" {
  bucket = "brewjacket-terraform-state"
  acl = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default { sse_algorithm = "AES256" }
    }
  }
}
