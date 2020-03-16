resource "aws_iam_user" "aaron_walls" {
  name = "aaron.walls"

  tags = {
    email = "aaron@brewjacket.com"
  }
}

resource "aws_iam_user" "robert_carpenter" {
  name = "robert.carpenter"
  tags = {
    email = "robert@tumblerlock.io"
    role  = "backend developer"
  }
}

resource "aws_iam_user" "david_young" {
  name = "david.young"

  tags = {
    email = "dave@youngcircuitdesigns.com"
    role = ""
  }
}

resource "aws_iam_user" "david_mollerstuen" {
  name = "david.mollerstuen"

  tags = {
    email = "dmollerstuen@alcaeng.com"
    role = "firmware developer"
  }
}

resource "aws_iam_user" "david_hoy" {
  name = "david.hoy"

  tags = {
    email = "david@thehoys.com"
    role = "firmware developer"
  }
}

resource "aws_iam_user" "ian_landi" {
  name = "ian.landi"

  tags = {
    email = "ian.landi.engineering@gmail.com"
    role = "firmware developer"
  }
}
