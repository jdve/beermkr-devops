resource "aws_route53_zone" "beermkr_app" { name = "beermkr.app" }

resource "aws_acm_certificate" "ssl" {
  domain_name = local.dns_name
  validation_method = "DNS"

  subject_alternative_names = [
    "*.${local.dns_name}"
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  zone_id = aws_route53_zone.beermkr_app.zone_id
  name = aws_acm_certificate.ssl.domain_validation_options.0.resource_record_name
  type = aws_acm_certificate.ssl.domain_validation_options.0.resource_record_type
  records = [aws_acm_certificate.ssl.domain_validation_options.0.resource_record_value]
  ttl = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = aws_acm_certificate.ssl.arn
  validation_record_fqdns = [ aws_route53_record.cert_validation.fqdn ]
}
