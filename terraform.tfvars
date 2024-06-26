region               = "us-west-2"
vpc_cidr             = "10.1.0.0/16"
vpc_name             = "web-vpc"
instance_type        = "t2.micro"
key_pair             = "key"
ami_id               = "ami-08116b9957a259459"
public_subnet_cidr   = ["10.1.1.0/24", "10.1.2.0/24"]
public_subnet2_cidr  = "10.1.2.0/24"
private_subnet_cidr  = ["10.1.3.0/24", "10.1.4.0/24"]
private_subnet2_cidr = "10.1.4.0/24"
public_subnet1_name  = "public-subnet-1"
public_subnet2_name  = "public-subnet-2"
private_subnet1_name = "private-subnet-1"
private_subnet2_name = "private-subnet-2"
availability_zone    = ["us-west-2a","us-west-2b"]

