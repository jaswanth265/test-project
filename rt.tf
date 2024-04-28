# route tables

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

#####test code##########

# Public Route Table and Public Subnet Association
resource "aws_route_table_association" "_public_rt_subnet_association" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# Private Route Table
resource "aws_route_table" "private_subnets" {
  vpc_id = aws_vpc.web-vpc.id
  #depends_on = [aws_nat_gateway.nat_gateway]
  tags = {
    Name = "private-rt"
  }
}

# Private Route Table and private Subnet Association
resource "aws_route_table_association" "private_rt_subnet_association" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_subnets.id
}

#####test code##########


# Public Route Table and Public Subnet Association
# resource "aws_route_table_association" "public_rt_subnet_association" {
#   subnet_id      = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
#   route_table_id = aws_route_table.public_route_table.id
# }


# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id     = aws_vpc.web-vpc.id
  depends_on = [aws_nat_gateway.nat_gateway]
  tags = {
    Name = "private-rt"
  }
}

# Private Route Table and private Subnet Association
# resource "aws_route_table_association" "private_rt_subnet_association" {
#   subnet_id      = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
#   route_table_id = aws_route_table.private_route_table.id
# }

