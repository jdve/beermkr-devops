resource "aws_route53_record" "firmware" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = local.dns_name
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.cloudfront.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.cloudfront.hosted_zone_id}"
    evaluate_target_health = true
  }
}
