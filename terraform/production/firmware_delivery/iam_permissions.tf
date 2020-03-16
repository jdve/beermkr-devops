resource "aws_iam_policy" "s3_access" {
  name        = "ota_firmware_bucket"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action":["s3:*"],
      "Resource":["${aws_s3_bucket.bucket.arn}"]
    }
  ]
}
EOF
}
