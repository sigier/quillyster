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
  default     = "ecs-nextio-"
}

variable "ami_id" {
  description = "Amazon Linux 2 ECS Optimized AMI ID"
  type        = string
  default     = "ami-0b74f796d330ab49c"
}

variable "instance_type" {
  description = "EC2 instance type for ECS cluster"
  type        = string
  default     = "t3.medium"
}

variable "secret_keys" {
  description = "List of secret keys stored in AWS Secrets Manager"
  type        = list(string)
  default     = [    
    "AUTH0_SECRET",
    "AUTH0_ISSUER_BASE_URL",
    "AUTH0_CLIENT_ID",
    "AUTH0_CLIENT_SECRET",  
    "OPENAI_API_KEY",  
    "STRIPE_SECRET_KEY",
    "STRIPE_PRODUCT_PRICE_ID",
    "STRIPE_WEBHOOK_SECRET",
    "MONGODB_URI"
  ]
}

variable "certificate" {
  description = "ALB certificate for HTTPS"
  type        = string
  default     = "arn:aws:acm:eu-central-1:785508583814:certificate/d7a33c37-1f0d-4eac-aca5-cbcaadbaafcf"
}