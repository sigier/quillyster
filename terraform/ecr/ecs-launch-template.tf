resource "aws_launch_template" "ecs_instances" {
  name_prefix   = var.instance_name_prefix
  image_id      = var.ami_id
  instance_type = var.instance_type
  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  }

  user_data = base64encode(<<-EOF
  #!/bin/bash

  if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" == "amzn" ]]; then
      sudo dnf update -y
    elif [[ "$ID" == "ubuntu" ]]; then
      sudo apt update -y && sudo apt upgrade -y
    fi
  fi


  if [[ "$ID" == "amzn" ]]; then
    sudo dnf install -y docker
  elif [[ "$ID" == "ubuntu" ]]; then
    sudo apt install -y docker.io
  fi
  sudo systemctl enable --now docker
  sudo usermod -aG docker ec2-user || sudo usermod -aG docker ubuntu


  if [[ "$ID" == "amzn" ]]; then
    curl -O https://s3.eu-central-1.amazonaws.com/amazon-ecs-agent-eu-central-1/amazon-ecs-init-latest.x86_64.rpm
    sudo yum localinstall -y amazon-ecs-init-latest.x86_64.rpm
  elif [[ "$ID" == "ubuntu" ]]; then
    curl -O https://s3.eu-central-1.amazonaws.com/amazon-ecs-agent-eu-central-1/amazon-ecs-init-latest.amd64.deb
    sudo dpkg -i amazon-ecs-init-latest.amd64.deb
  fi


  sudo mkdir -p /etc/ecs
  echo "ECS_CLUSTER=${aws_ecs_cluster.ecs_cluster.name}" | sudo tee /etc/ecs/ecs.config


  sudo systemctl enable --now ecs || echo "ECS agent failed to start"

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
