#ElasticIP 
resource "aws_eip" "eip" {
  # instance = aws_instance.web-server.id
  domain = "vpc"
}


#Nat gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = "{aws_subnet.public_subnet1.id,aws_subnet.public_subnet2.id}"

  tags = {
    Name = "NAT-GW"
  }
  depends_on = [aws_internet_gateway.public_internet_gateway]
}

# # Create EIP for NAT GW1
# resource "aws_eip" "eip_natgw1" {
#   count = "1"
# }

# # Create NAT gateway1

# resource "aws_nat_gateway" "natgateway_1" {
#   count         = "1"
#   allocation_id = aws_eip.eip_natgw1[count.index].id
#   subnet_id     = aws_subnet.pub_sub1.id
# }

# # Create EIP for NAT GW2

# resource "aws_eip" "eip_natgw2" {
#   count = "1"
# }

# # Create NAT gateway2

# resource "aws_nat_gateway" "natgateway_2" {
#   count         = "1"
#   allocation_id = aws_eip.eip_natgw2[count.index].id
#   subnet_id     = aws_subnet.pub_sub2.id
# }
