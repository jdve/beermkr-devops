resource "aws_s3_bucket" "bucket" {
  bucket = local.bucket_name

  acl    = "public-read"

  tags = {
    Name        = "beermkr firmware"
  }

  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"AddPerm",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${local.bucket_name}/*"]
    }
  ]
}
  POLICY

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}
