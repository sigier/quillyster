resource "aws_ecs_service" "nextio_service" {
  name            = "nextio-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.deploy-to-EC2-ecs.arn
  desired_count   = 1 
  launch_type     = "EC2"

  load_balancer {
    target_group_arn = aws_lb_target_group.alb-tg.arn
    container_name   = "nextio-container"
    container_port   = 3000
  }


  deployment_controller {
    type = "ECS"
  }

  deployment_minimum_healthy_percent = 50  
  deployment_maximum_percent         = 200 
  

  health_check_grace_period_seconds = 30  

  tags = {
    Name = "ECS-Service-Nextio"
  }
}
