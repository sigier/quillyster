resource "aws_launch_template" "ecs_instances" {
  name_prefix   = var.instance_name_prefix
  image_id      = var.ami_id
  instance_type = var.instance_type

  user_data = base64encode(<<-EOF
    #!/bin/bash
    echo "ECS_CLUSTER=${aws_ecs_cluster.ecs_cluster.name}" >> /etc/ecs/ecs.config
    sudo systemctl restart ecs
  EOF
  )

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30
      volume_type = "gp3"
      delete_on_termination = true
      encrypted = true
    }
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups  = [aws_security_group.ecs_sg.id]
  }
}
