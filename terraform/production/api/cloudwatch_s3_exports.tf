resource "aws_s3_bucket" "cloudwatch_s3_machine_logs" {
  bucket = "brewjacket-machine-logs"
  acl    = "private"

  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
        "Action": "s3:GetBucketAcl",
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::brewjacket-machine-logs",
        "Principal": { "Service": "logs.us-west-2.amazonaws.com" }
    },
    {
        "Action": "s3:PutObject" ,
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::brewjacket-machine-logs/*",
        "Condition": { "StringEquals": { "s3:x-amz-acl": "bucket-owner-full-control" } },
        "Principal": { "Service": "logs.us-west-2.amazonaws.com" }
    }
  ]
}
  POLICY
}
