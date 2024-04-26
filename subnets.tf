#subnets 


resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.web-vpc.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = "us-west-2a"

  tags = {
    Name = "${var.public_subnet1_name}"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.web-vpc.id
  cidr_block        = var.public_subnet2_cidr
  availability_zone = "us-west-2b"

  tags = {
    Name = "${var.public_subnet2_name}"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.web-vpc.id
  cidr_block        = var.private_subnet1_cidr
  availability_zone = "us-west-2a"

  tags = {
    Name = "${var.private_subnet1_name}"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.web-vpc.id
  cidr_block        = var.private_subnet2_cidr
  availability_zone = "us-west-2b"

  tags = {
    Name = "${var.private_subnet2_name}"
  }
}
