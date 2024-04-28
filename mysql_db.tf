resource "aws_db_subnet_group" "my_db_subnet_group" {
  # count      = length(aws_subnet.private_subnets)
  subnet_ids = [for subnet in aws_subnet.private_subnets : subnet.id]
  name       = "my-db-subnet-group"
  # subnet_ids = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
  tags = {
    Name = "MyDBSubnetGroup"
  }
}

# Create a RDS MySQL Instance
resource "aws_db_instance" "mydb" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.36"
  instance_class         = "db.t3.micro"
  db_name                = "mydatabase"
  username               = "admin"
  password               = "yourpassword"
  publicly_accessible    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_mysql_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name
  #db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.id
}

