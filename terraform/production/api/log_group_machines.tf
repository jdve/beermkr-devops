resource "aws_cloudwatch_log_group" "log_group_machines" {
  name = "${local.environment}/${local.app}/machines"

  tags = local.global_tags
}
