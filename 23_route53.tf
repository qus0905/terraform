resource "aws_route53_zone" "jybyun" {
  name = "jybyun.xyz"
}

resource "aws_route53_record" "frontend_www" {
  zone_id = "${aws_route53_zone.jybyun.zone_id}"
  type = "A"
  name = "www.jybyun.xyz"
  
  alias{
    evaluate_target_health = true
    name = aws_lb.pro_external_lb.dns_name
    zone_id = "${aws_lb.pro_external_lb.zone_id}"
  }    
  
}
resource "aws_route53_record" "frontend_A" {
  zone_id = "${aws_route53_zone.jybyun.zone_id}"
  type = "A"
  name = "jybyun.xyz"
  
  alias{
    evaluate_target_health = true
    name = aws_lb.pro_external_lb.dns_name
    zone_id = "${aws_lb.pro_external_lb.zone_id}"
  }    
  
}