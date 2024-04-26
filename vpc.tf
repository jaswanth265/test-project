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
