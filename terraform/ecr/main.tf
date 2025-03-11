provider "aws" {
  region = var.aws_region
  default_tags {
    tags = var.default_tags
  }
}

resource "aws_ecr_repository" "ecr_repo" {
  name = var.ecs_repository_name
  image_scanning_configuration {
    scan_on_push = true
  }
}
