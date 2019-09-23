terraform {
  backend "s3" {
    bucket = "brewjacket-terraform-state"
    key = "infrastructure/users/terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "terraform-state-locks"
  }
}

provider "aws" {
  version = "~> 2.19"
  region = "us-west-2"
}
