resource "aws_vpc" "tf_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name  = "tf_vpc_dev"
    Owner = var.owner
  }
}

resource "aws_subnet" "tf_subnet_public_1" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = "10.123.0.0/22"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Owner = var.owner
    Name  = "${var.type["public"]}_1"
    type  = var.type["public"]
  }
}

resource "aws_subnet" "tf_subnet_public_2" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = "10.123.8.0/22"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Owner = var.owner
    Name  = "${var.type["public"]}_2"
    type  = var.type["public"]
  }
}

resource "aws_subnet" "tf_subnet_public_3" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = "10.123.16.0/22"
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = true

  tags = {
    Owner = var.owner
    Name  = "${var.type["public"]}_3"
    type  = var.type["public"]
  }
}

resource "aws_subnet" "tf_subnet_internal_1" {
  vpc_id            = aws_vpc.tf_vpc.id
  cidr_block        = "10.123.4.0/22"
  availability_zone = "${var.region}a"

  tags = {
    Owner = var.owner
    Name  = "${var.type["private"]}_1"
    type  = var.type["private"]
  }
}

resource "aws_subnet" "tf_subnet_internal_2" {
  vpc_id            = aws_vpc.tf_vpc.id
  cidr_block        = "10.123.12.0/22"
  availability_zone = "${var.region}b"

  tags = {
    Owner = var.owner
    Name  = "${var.type["private"]}_2"
    type  = var.type["private"]
  }
}

resource "aws_subnet" "tf_subnet_internal_3" {
  vpc_id            = aws_vpc.tf_vpc.id
  cidr_block        = "10.123.20.0/22"
  availability_zone = "${var.region}c"

  tags = {
    Owner = var.owner
    Name  = "${var.type["private"]}_3"
    type  = var.type["private"]
  }
}

resource "aws_internet_gateway" "tf_dev_igw" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name  = "tf_dev_igw"
    Owner = var.owner
  }
}

resource "aws_route_table" "tf_route_table" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name  = "tf_dev_route_table"
    Owner = var.owner
    type  = var.type["public"]
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.tf_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tf_dev_igw.id
}

resource "aws_route_table_association" "rt_public_1_association" {
  subnet_id      = aws_subnet.tf_subnet_public_1.id
  route_table_id = aws_route_table.tf_route_table.id
}

resource "aws_route_table_association" "rt_public_2_association" {
  subnet_id      = aws_subnet.tf_subnet_public_2.id
  route_table_id = aws_route_table.tf_route_table.id
}

resource "aws_route_table_association" "rt_public_3_association" {
  subnet_id      = aws_subnet.tf_subnet_public_3.id
  route_table_id = aws_route_table.tf_route_table.id
}

resource "aws_security_group" "tf_dev_sg" {
  name        = "tf_dev_sg"
  description = "Default SG for VPC"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    description = "Allow my IP to VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["136.56.65.216/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf_dev_sg"
  }
}

