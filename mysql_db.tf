data "aws_secretsmanager_secret" "example1" {
  name = "rds_admin6"
  depends_on = [
    aws_secretsmanager_secret.example1
  ]
}

data "aws_secretsmanager_secret_version" "secret" {
  secret_id = data.aws_secretsmanager_secret.example1.id
}


# DB Subnet Groups 

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
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0.36"
  instance_class          = "db.t3.micro"
  db_name                 = "mydatabase"
  publicly_accessible     = true
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds_mysql_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.my_db_subnet_group.name
  password                = data.aws_secretsmanager_secret_version.secret.secret_string
  backup_retention_period = 0

  #db_subnet_group_name  = aws_db_subnet_group.my_db_subnet_group.id
  #username              = "admin"
  #assword               = "yourpassword"



}
