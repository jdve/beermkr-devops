resource "aws_acm_certificate" "ssl" {
  domain_name = local.dns_name
  validation_method = "DNS"

  tags = {
    Name = "${var.environment} ${var.generation}"
  }

  subject_alternative_names = [
    "*.${var.dns_name}"
  ]

  lifecycle {
    create_before_destroy = true
  }
}

