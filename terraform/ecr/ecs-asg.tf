resource "aws_autoscaling_group" "ecs_asg" {
  for_each = { for idx, subnet in aws_subnet.private : idx => subnet }

  desired_capacity     = 0
  min_size            = 0
  max_size            = 5

  vpc_zone_identifier = [each.value.id] 
  launch_template {
    id      = aws_launch_template.ecs_instances.id 
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.alb-tg.arn]

  tag {
    key                 = "Name"
    value               = "${var.instance_name_prefix}-${each.key}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "ecs_asg_attachment" {
  for_each = aws_autoscaling_group.ecs_asg

  autoscaling_group_name = each.value.id
  lb_target_group_arn   = aws_lb_target_group.alb-tg.arn
}
