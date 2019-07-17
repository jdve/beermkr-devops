resource "aws_db_instance" "database" {
  identifier           = "${local.environment}-${local.generation}"
  engine               = "postgres"
  engine_version       = local.database_version

  instance_class       = "db.t3.small"
  multi_az             = true
  storage_type         = "gp2"
  allocated_storage    = 20 #gb
  backup_retention_period = 7

  publicly_accessible  = true
  skip_final_snapshot  = false
  final_snapshot_identifier = "${local.environment}-${local.generation}-final-snapshot"

  apply_immediately = true

  # root database account credentials
  name                 = local.environment
  username             = local.database_username
  password             = local.database_default_password

  vpc_security_group_ids = [ aws_security_group.rds.id ]
  db_subnet_group_name = aws_db_subnet_group.rds_subnets.name

  lifecycle { ignore_changes = ["password", "engine_version"] }
}

resource "aws_security_group" "rds" {
  name_prefix = "${local.environment}-${local.generation}-rds"

  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
