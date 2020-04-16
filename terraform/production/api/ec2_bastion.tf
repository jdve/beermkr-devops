resource "aws_instance" "bastion_host" {
  ami           =  data.aws_ami.bastion.id
  instance_type = "t3a.nano"

  tags = {
    Name = "${local.environment}/Bastion"
  }

  associate_public_ip_address = true
  subnet_id = tolist(data.aws_subnet_ids.public.ids)[1]
  vpc_security_group_ids = [aws_security_group.bastion.id]

  iam_instance_profile = aws_iam_instance_profile.profile.name
}

resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Allow ssh connections from anywhere"

  vpc_id = data.aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "bastion" {
  name = "${local.environment}_${local.generation}_${local.app}_bastion"

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_instance_profile" "profile" {
  name = "${local.environment}-profile"
  role = aws_iam_role.bastion.name
}

