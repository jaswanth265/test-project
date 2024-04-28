variable "public_subnet_cidr" {
}
variable "public_subnet2_cidr" {
}
variable "private_subnet_cidr" {
}
variable "private_subnet2_cidr" {
}
variable "public_subnet1_name" {
}
variable "public_subnet2_name" {
}
variable "private_subnet1_name" {
}
variable "private_subnet2_name" {
}
variable "region" {

}
variable "subnet_group" {
  type    = list(string)
  default = ["10.1.3.0/24", "10.1.4.0/24"]
}
variable "alb_subnets" {
  type    = list(string)
  default = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "vpc_cidr" {

}

variable "vpc_name" {

}

variable "availability_zone" {

}

# variable "private_availability_zones" {
#   description = "Availability_zones for private subnets"
#     type = list(string)
# }


# variable "private_subnet_cidrs" {
#     description = "CIDR Blocks for private subnets"
#     type = list(string)

# }

variable "instance_type" {

}

variable "key_pair" {

}

variable "ami_id" {

}

variable "vpc_zone_identifier_cidrs" {
  type    = list(string)
  default = ["10.1.1.0/24", "10.1.2.0/24"]

}
