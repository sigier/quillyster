resource "aws_cloudwatch_event_rule" "ecr_push_rule" {
  name        = "ecr-push-blogerator"
  description = "Trigger ECS deployment after new image push to ECR"

  event_pattern = jsonencode({
    "source": ["aws.ecr"],
    "detail-type": ["ECR Image Action"],
    "detail": {
      "action-type": ["PUSH"],
      "repository-name": ["blogerator"],
      "result": ["SUCCESS"]
    }
  })
}


resource "aws_cloudwatch_event_target" "ecs_target" {
  rule     = aws_cloudwatch_event_rule.ecr_push_rule.name
  arn      = aws_ecs_cluster.ecs_cluster.arn
  role_arn = aws_iam_role.eventbridge_role.arn
  
  ecs_target {
    task_definition_arn = aws_ecs_task_definition.deploy-to-EC2-ecs.arn
    launch_type         = "EC2"
    task_count          = 1
  }
}
