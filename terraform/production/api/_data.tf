data "aws_vpc" "vpc" {
  id = "vpc-07b012e0075dc25df"
}

data "aws_subnet" "public_1" {
  id = "subnet-0f874f76d9e207901"
}

data "aws_subnet" "public_2" {
  id = "subnet-09043e3b796147764"
}

data "aws_ecs_cluster" "cluster" {
  cluster_name = "${local.environment}-${local.generation}"
}
