# ######## new code #######


resource "aws_eip" "nat_eip" {
  count  = length(aws_subnet.public_subnets)
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  count = length(aws_subnet.public_subnets)
  subnet_id     = aws_subnet.public_subnets[count.index].id
  allocation_id = aws_eip.nat_eip[count.index].id
  tags = {
    Name = "nat-gateway-${count.index + 1}"
  }
}






























































































#ElasticIP 
# resource "aws_eip" "eip1" {
#   # instance = aws_instance.web-server.id
#   domain = "vpc"
# }

# resource "aws_eip" "eip2" {
#   # instance = aws_instance.web-server.id
#   domain = "vpc"
# }

# resource "aws_nat_gateway" "nat_gateway" {
#   for_each      = toset(["aws_subnet.public_subnet1.id", "aws_subnet.public_subnet2.id"]) # Subnet names here
#   allocation_id = aws_eip.eip.id
#   subnet_id     = aws_subnet[each.value].id
# }



#Nat gateway
# resource "aws_nat_gateway" "nat_gateway1" {
#   allocation_id = aws_eip.eip1.id
#   # subnet_id     = [for subnet in aws_subnet.public_subnets : subnet.id]
#   subnet_id = aws_subnet.public_subnet1.id

#   tags = {
#     Name = "NAT-GW-1"
#   }
#   depends_on = [aws_internet_gateway.public_internet_gateway]
# }

# resource "aws_nat_gateway" "nat_gateway2" {
#   allocation_id = aws_eip.eip2.id
#   # subnet_id     = "10.1.1.0/24"
#   subnet_id = [for subnet in aws_subnet.public_subnets : subnet.id]

#   tags = {
#     Name = "NAT-GW-2"
#   }
#   depends_on = [aws_internet_gateway.public_internet_gateway]
# }



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




# ######## new code #######


# resource "aws_eip" "nat_eip" {
#   count  = length(aws_subnet.public_subnets)
#   domain = "vpc"
# }

# resource "aws_nat_gateway" "nat_gateway" {
#   count = length(aws_subnet.public_subnets)

#   subnet_id     = aws_subnet.public_subnets[count.index].id
#   allocation_id = aws_eip.nat_eip[count.index].id

#   tags = {
#     Name = "nat-gateway-${count.index + 1}"
#   }
# }
