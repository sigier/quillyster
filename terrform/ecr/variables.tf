variable "aws_region" {
  description = "AWS Region"  
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "ecs_cluster_name" {
  description = "ECS Cluster Name"
  type        = string
  default     = "blogeratorio-cluster"
}


variable "ecs_repository_name" {
  description = "ECS Repository Name"
  type        = string
  default     = "blogerator"
}

variable "default_tags" {
  type    = map(string)
  default = {
    program = "nextio"
  }
}