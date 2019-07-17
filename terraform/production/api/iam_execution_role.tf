resource "aws_iam_role" "execution_role" {
  name = "${local.environment}-${local.generation}-${local.app}-ecs-execution-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "execution_policy" {
  name_prefix = "${local.environment}-${local.generation}-${local.app}-execution-policy"
  description = ""

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "statement0",
      "Action": [
        "ecr:GetAuthorizationToken"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
    ,

    {
        "Sid": "statement1",
        "Effect": "Allow",
        "Action": [
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "ecr:DescribeImages",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetRepositoryPolicy"
        ],
        "Resource": "${aws_ecr_repository.repository.arn}"
    }

    ,

    {
        "Sid": "statement2",
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": [
          "${aws_cloudwatch_log_group.log_group.arn}"
        ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "execution_role_attach_1" {
    role       = aws_iam_role.execution_role.name
    policy_arn = aws_iam_policy.execution_policy.arn
}
