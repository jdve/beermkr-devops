resource "aws_iam_user" "circle_ci" {
  name = "circleci"
  tags = {
    role = "service role for CircleCI to run automated deployments"
  }
}
