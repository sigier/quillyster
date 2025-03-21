resource "aws_ecs_capacity_provider" "ecs_asg_capacity_1" {
  name = "asg-capacity-1"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs_asg["0"].arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 100
    }
  }
}

resource "aws_ecs_capacity_provider" "ecs_asg_capacity_2" {
  name = "asg-capacity-2"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs_asg["1"].arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 100
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "ecs_cluster_capacity" {
  cluster_name = aws_ecs_cluster.ecs_cluster.name

  capacity_providers = [
    aws_ecs_capacity_provider.ecs_asg_capacity_1.name,
    aws_ecs_capacity_provider.ecs_asg_capacity_2.name
  ]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs_asg_capacity_1.name
    weight            = 1
  }

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs_asg_capacity_2.name
    weight            = 1
  }
}
