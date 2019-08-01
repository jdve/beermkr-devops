resource "aws_acm_certificate" "ssl" {
  domain_name = local.dns_name
  validation_method = "DNS"

  tags = {
    Name = "${local.environment} ${local.generation}"
  }

  subject_alternative_names = [
    "*.${local.dns_name}"
  ]

  lifecycle {
    create_before_destroy = true
  }
}

