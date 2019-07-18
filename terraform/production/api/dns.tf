resource "aws_route53_record" "api" {
  zone_id = data.aws_route53_zone.beermkr_app.zone_id
  name    = "api.beermkr.app"
  type    = "A"

  alias {
    name = aws_lb.lb.dns_name
    zone_id = aws_lb.lb.zone_id
    evaluate_target_health = false
  }
}
