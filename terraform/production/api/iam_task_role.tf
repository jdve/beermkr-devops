resource "aws_iam_role" "task_role" {
  name = "${local.environment}-${local.generation}-${local.app}-ecs-task-role"

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

resource "aws_iam_policy" "task_policy" {
  name_prefix = "${local.environment}-${local.generation}-${local.app}-task-policy"
  description = ""

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Sid": "statement0",
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": [
          "${aws_cloudwatch_log_group.log_group_machines.arn}"
        ]
    }
    ,
    {
        "Sid": "statement1",
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": [
          "${aws_cloudwatch_log_group.log_group_brew_history.arn}"
        ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "task_role_attach_1" {
    role       = aws_iam_role.task_role.name
    policy_arn = aws_iam_policy.task_policy.arn
}
