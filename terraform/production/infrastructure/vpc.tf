resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "public_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  map_public_ip_on_launch = true

  tags = { Name = "west-2a public" }
}

resource "aws_subnet" "public_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-west-2d"

  map_public_ip_on_launch = true

  tags = { Name = "west-2d public" }
}

resource "aws_subnet" "private_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  map_public_ip_on_launch = false

  tags = { Name = "west-2b private" }
}

resource "aws_subnet" "private_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-2c"

  map_public_ip_on_launch = false

  tags = { Name = "west-2c private" }
}

resource "aws_db_subnet_group" "rds_subnets" {
  subnet_ids = [ aws_subnet.private_1.id , aws_subnet.private_2.id ]
}

resource "aws_route_table" "routes" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }
}

resource "aws_main_route_table_association" "main_association" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.routes.id
}

resource "aws_route_table_association" "association_public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.routes.id
}

resource "aws_route_table_association" "association_public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.routes.id
}

resource "aws_route_table_association" "association_private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.routes.id
}

resource "aws_route_table_association" "association_private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.routes.id
}
