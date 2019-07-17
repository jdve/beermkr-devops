resource "aws_ecs_cluster" "cluster" {
  name = "${local.environment}-${local.generation}"
}
