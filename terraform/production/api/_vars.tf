locals {
  dns_name = "api.beermkr.app"

  environment = "production"
  generation = "alpaca"
  app = "api"

  health_check = {
    path = "/ping"
    matcher = 200
    interval = 5
    healthy_threshold = 2
    unhealthy_threshold = 5
    timeout = 2
  }

  environment_vars = [{
    name = "RAILS_ENV",
    value = "production"
  }]

  secret_vars = [{
    "name": "DATABASE_URL",
    "valueFrom": "arn:aws:ssm:us-west-2:279309378976:parameter/beermkr/env/database_url"
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
