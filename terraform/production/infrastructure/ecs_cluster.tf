resource "aws_ecs_cluster" "cluster" {
  name = "${local.environment}-${local.generation}"
}

resource "aws_iam_policy" "update_ecs_service" {
  name = "circle_update_ecs_cluster"
  description = "Allows attachments to update ecs clusters"

  policy = <<JSON
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "Statement0",
          "Effect": "Allow",
          "Action": "ecr:GetAuthorizationToken",
          "Resource": "*"
      },
      {
        "Sid": "Statement1",
        "Effect": "Allow",
        "Action": "ecs:UpdateService",
        "Resource": "*"
      },
      {
        "Sid": "Statement2",
        "Effect": "Allow",
        "Action": "iam:PassRole",
        "Resource": "*"
      },
      {
          "Sid": "Statement3",
          "Effect": "Allow",
          "Action": [
            "ecr:InitiateLayerUpload",
            "ecr:UploadLayerPart",
            "ecr:CompleteLayerUpload",
            "ecr:PutImage",
            "ecr:TagResource",
            "ecr:UntagResource",
            "ecr:ListTagsForResource",
            "ecr:ListImages",
            "ecr:DescribeImages",
            "ecr:DescribeRepositories"
          ],
          "Resource": "*"
      }
  ]
}
JSON
}

resource "aws_iam_user_policy_attachment" "circleci_update_cluster" {
  user = data.aws_iam_user.circle_ci.user_name
  policy_arn = aws_iam_policy.update_ecs_service.arn
}
