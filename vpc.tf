resource "aws_vpc" "web-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    env  = "prod"
    Name = "var.vpc_name"

  }

  #  depends_on = [aws_iam_policy.ec2_full_access]
}


# Setup Internet Gateway
resource "aws_internet_gateway" "public_internet_gateway" {
  vpc_id = aws_vpc.web-vpc.id
  tags = {
    Name = "igw"
  }
}


resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.web-vpc.id
  service_name = "com.amazonaws.us-west-2.s3"


}

resource "aws_vpc_endpoint_route_table_association" "rta" {
  route_table_id  = aws_route_table.public_route_table.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

# #ElasticIP 
# resource "aws_eip" "eip" {
#   instance = aws_instance.web-server.id
#   domain   = "vpc"
# }

# #Nat gateway
# resource "aws_nat_gateway" "nat_gateway" {
#   allocation_id = aws_eip.eip.id
#   subnet_id     = "{aws_subnet.public_subnet1.id,aws_subnet.public_subnet2.id}"

#   tags = {
#     Name = "NAT-GW"
#   }
#   depends_on = [aws_internet_gateway.public_internet_gateway]
# }
