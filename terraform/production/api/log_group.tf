resource "aws_cloudwatch_log_group" "log_group" {
  name = "${local.environment}/${local.app}"
  retention_in_days = 14

  tags = local.global_tags
}
