locals {
  environment = "production"
  generation = "alpaca"
  app = "api"

  health_check = {
    path = "/"
    matcher = 200
    interval = 10
    healthy_threshold = 2
    unhealthy_threshold = 10
  }

  environment_vars = [{
    name = "RAILS_ENV",
    value = "production"
  }]

  public_subnets = [
    data.aws_subnet.public_1.id,
    data.aws_subnet.public_2.id
  ]

  global_tags = { }

  port = 3000
  cpu = 1024
  memory = 2048
  image_tag = "production"
}
