resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

data "aws_ssm_parameter" "auth0_base_url" {
  name = "AUTH0_BASE_URL"
}


data "aws_secretsmanager_secret_version" "blogerator" {
  secret_id = "blogerator"
}

locals {
  blogerator_secrets = jsondecode(data.aws_secretsmanager_secret_version.blogerator.secret_string)
}


 resource "aws_ecs_task_definition" "deploy-to-EC2-ecs" {
  family                   = "nextio-deploy-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn 

  container_definitions = jsonencode([
    {
      name              = "nextio-container"
      image             = "785508583814.dkr.ecr.eu-central-1.amazonaws.com/blogerator:latest"
      memoryReservation = 128
      cpu               = 128
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]

    environment = concat(
      [
        {
          name  = "AUTH0_BASE_URL"
          value = data.aws_ssm_parameter.auth0_base_url.value
        }
      ],
      [
        for key in var.secret_keys : {
          name  = key
          value = local.blogerator_secrets[key]
        }
      ]
    )
    }
  ])
}
