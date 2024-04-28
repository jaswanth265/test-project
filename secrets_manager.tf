#Secrets Manager

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "rds" {
  kms_key_id              = aws_kms_key.key.id
  name                    = "rds_admin6"
  description             = "RDS Admin password"
  recovery_window_in_days = 14

  tags = {
    Name = "Secrets-Manager"
  }
}

resource "aws_secretsmanager_secret_version" "secrets" {
  secret_id     = aws_secretsmanager_secret.rds.id
  secret_string = random_password.password.result
}
