resource "aws_cloudfront_distribution" "cloudfront" {
  origin {
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    domain_name = aws_s3_bucket.bucket.website_endpoint
    origin_id   = local.bucket_name
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = local.bucket_name

    # viewer_protocol_policy = "redirect-to-https"
    viewer_protocol_policy = "allow-all"
    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    min_ttl                = 0
    default_ttl            = 30
    max_ttl                = 300

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  aliases = [local.dns_name]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "arn:aws:acm:us-east-1:279309378976:certificate/1faf70b7-73a6-493d-b0a2-1c1a15f67595"
    ssl_support_method  = "sni-only"
  }
}
