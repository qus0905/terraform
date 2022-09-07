resource "aws_cloudfront_distribution" "pro_cf" {
  origin_group {
    origin_id="pro-cdn"

    failover_criteria {
      status_codes = [403, 404, 500, 502]
    }

    member {
      origin_id="main-elb"
    }

    member {
      origin_id="error-s3"
    }
  }

  origin {
    domain_name=aws_lb.pro_external_lb.dns_name
    origin_id="main-elb"

    custom_origin_config{
        http_port="80"
      https_port="443"
      origin_protocol_policy="http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }
  
  origin {
    domain_name=aws_s3_bucket.main_bucket.bucket_regional_domain_name
    origin_id = "error-s3"

    custom_origin_config{
      http_port="80"
      https_port="443"
      origin_protocol_policy="http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

  }
  enabled = true
  default_root_object ="/Musteat"
  is_ipv6_enabled = true
  aliases = ["jybyun.xyz", "www.jybyun.xyz"]
  
  default_cache_behavior {
    target_origin_id="main-elb"
    compress = true
    viewer_protocol_policy = "redirect-to-https"
     allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    
    forwarded_values {
        query_string = false
        cookies{
            forward="none"
        }
      
    }
    
  }

  ordered_cache_behavior {
    path_pattern = "/error.html"
    target_origin_id="error-s3"
    compress=true
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    
    forwarded_values {
        query_string = false
        cookies{
            forward="none"
        }
      
    }

  }
  restrictions{
     geo_restriction {
      restriction_type = "none"
    }
  }
   viewer_certificate{
      cloudfront_default_certificate = true
      ssl_support_method = "sni-only"
      acm_certificate_arn = "arn:aws:acm:us-east-1:845480526715:certificate/1892e3bf-4fa7-4c3a-bd3d-cc26509e8eb2"
  }

  tags = {
    Environment="pro-cdn"
  }

  custom_error_response {

    error_caching_min_ttl = 10
    error_code = 502
    response_code = 503
    response_page_path = "/error.html"

  }
}