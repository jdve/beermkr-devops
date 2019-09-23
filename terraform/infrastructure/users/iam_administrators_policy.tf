resource "aws_iam_group" "administrators" {
  name = "administrators"
}

resource "aws_iam_group_membership" "administrators" {
  group = aws_iam_group.administrators.name
  name = "administrators"

  users = [
    aws_iam_user.aaron_walls.name,
    aws_iam_user.robert_carpenter.name
  ]
}

resource "aws_iam_group_policy_attachment" "administrators" {
  group = aws_iam_group.administrators.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
