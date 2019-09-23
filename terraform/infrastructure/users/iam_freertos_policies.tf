resource "aws_iam_group" "free_rtos_developers" {
  name = "free_rtos_developers"
}

resource "aws_iam_group_membership" "free_rtos_developers" {
  group = aws_iam_group.free_rtos_developers.name
  name = "free_rtos_developers"

  users = [
    aws_iam_user.david_mollerstuen.name,
    aws_iam_user.david_hoy.name,
    aws_iam_user.ian_landi.name
  ]
}

resource "aws_iam_group_policy_attachment" "free_rtos_developers_freertos_access" {
  group = aws_iam_group.free_rtos_developers.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonFreeRTOSFullAccess"
}

resource "aws_iam_group_policy_attachment" "free_rtos_developers_iot_access" {
  group = aws_iam_group.free_rtos_developers.name
  policy_arn = "arn:aws:iam::aws:policy/AWSIoTFullAccess"
}
