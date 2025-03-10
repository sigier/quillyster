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

variable "instance_name_prefix" {
  description = "Prefix for ECS instances"
  type        = string
  default     = "ecs-instance-"
}

variable "ami_id" {
  description = "Amazon Linux 2 ECS Optimized AMI ID"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  description = "EC2 instance type for ECS cluster"
  type        = string
  default     = "t3.micro"
}

