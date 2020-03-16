data "aws_route53_zone" "domain" {
  name = "beermkr.app"
}

data "aws_iam_group" "group" {
  group_name = "free_rtos_developers"
}
