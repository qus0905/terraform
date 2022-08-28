resource "aws_route53_zone" "jybyun" {
  name = "jybyun.xyz"
}

resource "aws_route53_record" "frontend_www" {
  zone_id = aws_route53_zone.jybyun.zone_id
  name    = var.www_domain_name
  type    = "A"

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.pro_cf.domain_name
    zone_id                = aws_cloudfront_distribution.pro_cf.hosted_zone_id
  }
  depends_on = [
    aws_cloudfront_distribution.pro_cf
  ]
}
resource "aws_route53_record" "frontend_root" {
  zone_id = aws_route53_zone.jybyun.zone_id
  type    = "A"
  name    = var.root_domain_name

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.pro_cf.domain_name
    zone_id                = aws_cloudfront_distribution.pro_cf.hosted_zone_id
  }
  depends_on = [
    aws_cloudfront_distribution.pro_cf
  ]
}

output "NS" {
  value=aws_route53_zone.jybyun.name_servers
}