data "aws_vpc" "vpc" {
  id = "vpc-07b012e0075dc25df"
}

data "aws_iam_user" "circle_ci" {
  user_name = "circleci"
}
