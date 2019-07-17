resource "aws_lb" "lb" {
  name               = "${local.environment}-${local.generation}-${local.app}"
  security_groups    = [aws_security_group.lb.id]
  subnets            = local.public_subnets
}

resource "aws_lb_target_group" "target_group" {
  name = "${local.environment}-${local.generation}-${local.app}"
  port = 80
  protocol = "HTTP"
  vpc_id = data.aws_vpc.vpc.id

  health_check {
    path = local.health_check.path
  }

  deregistration_delay = 0

  target_type = "ip"
}

resource "aws_security_group" "lb" {
  name        = "${local.environment}-${local.generation}-${local.app}-lb"
  description = "allow http/s traffic"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "task" {
  name        = "${local.environment}-${local.generation}-${local.app}-task"
  description = "allow traffic from lb"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port   = local.port
    to_port     = local.port
    protocol    = "tcp"
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = "${aws_lb.lb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
