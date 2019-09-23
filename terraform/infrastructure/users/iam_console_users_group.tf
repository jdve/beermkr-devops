resource "aws_iam_group" "console_users" {
  name = "console_users"
}

resource "aws_iam_group_membership" "console_users" {
  group = aws_iam_group.console_users.name
  name = "console_users"

  users = [
    aws_iam_user.aaron_walls.name,
    aws_iam_user.david_hoy.name,
    aws_iam_user.david_mollerstuen.name,
    aws_iam_user.ian_landi.name,
    aws_iam_user.robert_carpenter.name
  ]
}

resource "aws_iam_group_policy_attachment" "change_password" {
  group = aws_iam_group.console_users.name
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}
