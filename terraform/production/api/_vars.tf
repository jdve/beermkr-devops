locals {
  dns_name = "beermkr.app"

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

  environment_vars = [
    {
      name = "RAILS_ENV",
      value = "production"
    }
  ]

  secret_vars = [
    {
      "name": "DATABASE_URL",
      "valueFrom": "arn:aws:ssm:us-west-2:279309378976:parameter/beermkr/env/database_url"
    },
    {
      name = "SECRET_KEY_BASE",
      valueFrom = "arn:aws:ssm:us-west-2:279309378976:parameter/beermkr/env/secret_key_base"
    },
    {
      name = "SENDGRID_API_KEY",
      valueFrom = "arn:aws:ssm:us-west-2:279309378976:parameter/beermkr/env/SENDGRID_API_KEY"
    },
    {
      name = "STRIPE_SECRET_KEY",
      valueFrom = "arn:aws:ssm:us-west-2:279309378976:parameter/beermkr/env/STRIPE_SECRET_KEY"
    }
  ]

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
