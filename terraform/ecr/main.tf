provider "aws" {
    region = var.aws_region
    default_tags {
    tags = var.default_tags
  }
}

terraform {
  backend "s3" {
    bucket         = var.s3_tfstate_bucket_name
    key            = "state/terraform.tfstate"
    region         =  var.aws_region
    encrypt        = true
  }


resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = var.s3_tfstate_bucket_name
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_bucket_encryption" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


resource "aws_ecr_repository" "ecr_repo" {
    name = var.ecs_repository_name
    image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}