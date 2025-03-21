resource "aws_iam_service_linked_role" "ecs_service_role" {
  aws_service_name = "ecs.amazonaws.com"
}
