resource "aws_iam_user" "robert_carpenter" {
  name = "robert.carpenter"
  tags = {
    email = "robert@tumblerlock.io"
    role  = "backend developer"
  }
}
