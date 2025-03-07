data "aws_ssm_parameter" "auth0_base_url" {
  name = "AUTH0_BASE_URL"
}

data "aws_secretsmanager_secret" "blogerator" {
  name = "blogerator"
}

data "aws_secretsmanager_secret_version" "blogerator_version" {
  secret_id = data.aws_secretsmanager_secret.blogerator.id
}