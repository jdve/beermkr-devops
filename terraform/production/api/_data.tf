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

data "aws_iam_policy" "parameter_read_policy" {
  arn = "arn:aws:iam::279309378976:policy/production-environment-read-env20190718161158830900000004"
}

data "aws_route53_zone" "beermkr_app" {
  name = "beermkr.app"
}

data "aws_acm_certificate" "beermkr_app" {
  domain   = "beermkr.app"
  statuses = ["ISSUED"]
}
