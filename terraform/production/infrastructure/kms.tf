locals {
  parameter_arn_prefix = "arn:aws:ssm:${local.region}:${local.account_id}:parameter/${local.parameter_namespace}"
}

resource "aws_kms_key" "key" {
  description = "Encryption key for ${local.environment} environment secrets"
  key_usage = "ENCRYPT_DECRYPT"
  is_enabled = true
}

resource "aws_kms_alias" "alias" {
  name          = "alias/${local.environment}"
  target_key_id = "${aws_kms_key.key.key_id}"
}

resource "aws_iam_policy" "read_env_policy" {
  name_prefix = "${local.environment}-environment-read-env"
  description = "Allows decryption of parameters stored in the ${local.environment} environment parameter store."

  policy = <<JSON
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "statement1",
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt",
                "ssm:DescribeParameters",
                "kms:DescribeKey"
            ],
            "Resource": [
              "${aws_kms_key.key.arn}",
              "arn:aws:ssm:${local.region}:${local.account_id}:*"
            ]
        },
        {
          "Sid": "statement2",
          "Effect": "Allow",
          "Action": [
            "ssm:GetParametersByPath",
            "ssm:GetParameter",
            "ssm:GetParameters"
          ],
          "Resource": [
            "${local.parameter_arn_prefix}/env/*",
            "${local.parameter_arn_prefix}/env"
          ]
        },
        {
          "Sid": "statement3",
          "Effect": "Allow",
          "Action": [
            "kms:ListKeys",
            "kms:ListAliases"
          ],
          "Resource": "*"
        }
    ]
}
JSON

  lifecycle { create_before_destroy = true }
}

resource "aws_iam_policy" "read_all_policy" {
  name_prefix = "${local.environment}-environment-read-all"
  description = "Allows decryption of parameters stored in the ${local.environment} parameter store."

  policy = <<JSON
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "statement1",
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt",
                "ssm:DescribeParameters",
                "kms:DescribeKey"
            ],
            "Resource": [
              "${aws_kms_key.key.arn}",
              "arn:aws:ssm:${local.region}:${local.account_id}:*"
            ]
        },
        {
          "Sid": "statement2",
          "Effect": "Allow",
          "Action": [
            "ssm:DescribeParameters",
            "ssm:GetParametersByPath",
            "ssm:GetParameter",
            "ssm:GetParameters"
          ],
          "Resource": [
            "${local.parameter_arn_prefix}/*",
            "${local.parameter_arn_prefix}"
          ]
        },
        {
          "Sid": "statement3",
          "Effect": "Allow",
          "Action": [
            "kms:ListKeys",
            "kms:ListAliases"
          ],
          "Resource": "*"
        }
    ]
}
JSON

  lifecycle { create_before_destroy = true }
}

resource "aws_iam_policy" "write_env_policy" {
  name_prefix = "${local.environment}-parameter-write-env"
  description = "Allows attachments to update and encrypt parameters for the ${local.environment} environment."

  policy = <<JSON
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "statement1",
            "Effect": "Allow",
            "Action": [
                "kms:Encrypt",
                "kms:DescribeKey"
            ],
            "Resource": [ "${aws_kms_key.key.arn}" ]
        },
        {
          "Sid": "statement3",
          "Effect": "Allow",
          "Action": [
            "kms:ListKeys",
            "kms:ListAliases"
          ],
          "Resource": "*"
        },
        {
          "Sid": "statement4",
          "Effect": "Allow",
          "Action": ["ssm:PutParameter", "ssm:GetParameter", "ssm:DescribeParameters"],
          "Resource": "${local.parameter_arn_prefix}/env/*"
        }
    ]
}
JSON

  lifecycle { create_before_destroy = true }
}

resource "aws_iam_policy" "write_all_policy" {
  name_prefix = "${local.environment}-parameter-write-all"
  description = "Allows attachments to update and encrypt parameters for the ${local.environment} environment."

  policy = <<JSON
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "statement1",
            "Effect": "Allow",
            "Action": [
                "kms:Encrypt",
                "kms:DescribeKey"
            ],
            "Resource": [ "${aws_kms_key.key.arn}" ]
        },
        {
          "Sid": "statement2",
          "Effect": "Allow",
          "Action": [
            "kms:ListKeys",
            "kms:ListAliases"
          ],
          "Resource": "*"
        },
        {
          "Sid": "statement3",
          "Effect": "Allow",
          "Action": ["ssm:PutParameter", "ssm:GetParameter", "ssm:DescribeParameters"],
          "Resource": "${local.parameter_arn_prefix}/*"
        }
    ]
}
JSON

  lifecycle { create_before_destroy = true }
}
