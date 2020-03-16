terraform {
  backend "s3" {
    bucket = "brewjacket-terraform-state"
    key = "production/firmware_delivery/terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "terraform-state-locks"
  }
}

provider "aws" {
  version = "~> 2.33"
  region = "us-west-2"
}
