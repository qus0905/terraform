resource "aws_s3_bucket" "main_bucket" {
    bucket = "${var.root_domain_name}"
}

resource "aws_s3_bucket_versioning" "main_version" {
  bucket = aws_s3_bucket.main_bucket.id
  versioning_configuration {
    status="Enabled"
  }
}

resource "aws_s3_bucket_acl" "main_acl" {
  bucket = aws_s3_bucket.main_bucket.id
  acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "main_bucket" {
    bucket = aws_s3_bucket.main_bucket.id

  index_document {
    suffix="error.html"
  }

}

resource "aws_s3_object" "error_object" {
   key = "error.html"
    bucket = aws_s3_bucket.main_bucket.id
    source = "error.html"
    acl = "public-read"
    content_type="text/html"
}

resource "aws_s3_object" "sytle_object" {
   key = "style.css"
    bucket = aws_s3_bucket.main_bucket.id
    source = "./style.css"
    acl = "public-read"
    content_type="text/css"
}

resource "aws_s3_object" "img_object" {
    key="error.png"
    bucket = aws_s3_bucket.main_bucket.id
    source = "./error.png"
    acl = "public-read"
}
