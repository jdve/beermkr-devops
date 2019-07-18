resource "aws_ecs_task_definition" "definition" {
  cpu = local.cpu
  memory = local.memory

  container_definitions = data.template_file.container.rendered
  execution_role_arn = aws_iam_role.execution_role.arn

  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"

  family = "${local.environment}-${local.generation}-${local.app}"

  # tags = local.global_tags
}

data "template_file" "container" {
  template = file("container.json")

  vars = {
    name = "${local.environment}-${local.generation}-${local.app}"
    cpu = local.cpu
    memory = local.memory
    environment = jsonencode(local.environment_vars)
    secrets = jsonencode(local.secret_vars)

    port = local.port
    log_group = aws_cloudwatch_log_group.log_group.name
    log_region = "us-west-2"
    log_prefix = local.app
    image = "${aws_ecr_repository.repository.repository_url}:${local.image_tag}"
  }
}

resource "aws_ecs_service" "service" {
  name = "${local.environment}-${local.generation}-${local.app}"
  cluster = data.aws_ecs_cluster.cluster.cluster_name

  task_definition = aws_ecs_task_definition.definition.arn
  desired_count = "2"

  platform_version = "LATEST"
  launch_type = "FARGATE"

  enable_ecs_managed_tags = true
  propagate_tags = "TASK_DEFINITION"

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name = "${local.environment}-${local.generation}-${local.app}"
    container_port = local.port
  }

  network_configuration {
    assign_public_ip = true
    security_groups = [ aws_security_group.task.id ]
    subnets = local.public_subnets
  }
}
