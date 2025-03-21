resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}


resource "aws_ecs_task_definition" "deploy-to-EC2-ecs" {
  family                   = "nextio-deploy-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]

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
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/nextio-container"
          awslogs-region        = "eu-central-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}