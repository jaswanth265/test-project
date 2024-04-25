resource "aws_vpc" "web-vpc" {
   cidr_block = var.vpc_cidr
   enable_dns_hostnames = true
   enable_dns_support = true
   tags={
    env = "prod"
    Name = "var.vpc_name" 

   }

  #  depends_on = [aws_iam_policy.ec2_full_access]
}


resource "aws_subnet" "public_subnet1" {
    vpc_id = "${aws_vpc.web-vpc.id}"
    cidr_block = "${var.public_subnet1_cidr}"
    availability_zone = "us-west-2a"

    tags = {
        Name = "${var.public_subnet1_name}"
    }
}

resource "aws_subnet" "public_subnet2" {
    vpc_id = "${aws_vpc.web-vpc.id}"
    cidr_block = "${var.public_subnet2_cidr}"
    availability_zone = "us-west-2b"

    tags = {
        Name = "${var.public_subnet2_name}"
    }
}

resource "aws_subnet" "private_subnet1" {
    vpc_id = "${aws_vpc.web-vpc.id}"
    cidr_block = "${var.private_subnet1_cidr}"
    availability_zone = "us-west-2a"

    tags = {
        Name = "${var.private_subnet1_name}"
    }
}

resource "aws_subnet" "private_subnet2" {
    vpc_id = "${aws_vpc.web-vpc.id}"
    cidr_block = "${var.private_subnet2_cidr}"
    availability_zone = "us-west-2b"

    tags = {
        Name = "${var.private_subnet2_name}"
    }
}

# Setup Internet Gateway
resource "aws_internet_gateway" "public_internet_gateway" {
  vpc_id = aws_vpc.web-vpc.id
  tags = {
    Name = "igw"
  }
}

#ElasticIP 
resource "aws_eip" "lb" {
  instance = aws_instance.web-server.id
  domain   = "vpc"
}

#Nat gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = {
    Name = "NAT-GW"
  }
  depends_on = [aws_internet_gateway.public_internet_gateway]
}

# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.web-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_internet_gateway.id
  }
  tags = {
    Name = "public-rt"
  }
}

# Public Route Table and Public Subnet Association
resource "aws_route_table_association" "public_rt_subnet_association" {
  subnet_id      = "{aws_subnet.public_subnet1.id,aws_subnet.public_subnet2.id}"
  route_table_id = aws_route_table.public_route_table.id
}


# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.web-vpc.id
  depends_on = [aws_nat_gateway.nat_gateway]
  tags = {
    Name = "private-rt"
  }
}

# Private Route Table and private Subnet Association
resource "aws_route_table_association" "private_rt_subnet_association" {
  subnet_id      = "{aws_subnet.private_subnet1.id,aws_subnet.private_subnet2.id}"
  route_table_id = aws_route_table.private_route_table.id
}