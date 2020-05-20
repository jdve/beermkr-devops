resource "aws_cloudwatch_log_group" "log_group_brew_history" {
  name = "${local.environment}/${local.app}/brew_history"

  tags = local.global_tags
}
