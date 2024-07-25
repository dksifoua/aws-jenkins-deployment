resource "aws_ecs_cluster" "jenkins" {
  name = "jenkins-ecs"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = var.tags
}

resource "aws_ecs_cluster" "agent_spot" {
  name = "jenkins-agent-spot-ecs"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = var.tags
}

resource "aws_ecs_cluster_capacity_providers" "jenkins" {
  cluster_name       = aws_ecs_cluster.jenkins.name
  capacity_providers = ["FARGATE"]
  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base              = 1
  }
}

/*resource "aws_ecs_cluster_capacity_providers" "agent_spot" {
  cluster_name       = aws_ecs_cluster.agent_spot.name
  capacity_providers = ["FARGATE_SPOT"]
  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    base              = 1
  }
}*/

resource "aws_ecs_task_definition" "jenkins_controller" {
  container_definitions = templatefile("${path.module}/templates/jenkins_controller.json", {
    name      = var.jenkins_controller_container
    image     = var.jenkins_controller_image
    cpu       = var.jenkins_controller_cpu
    memory    = var.jenkins_controller_memory
    log_group = aws_cloudwatch_log_group.ecs.name
    region    = data.aws_region.current.name
  })
  family                   = "jenkins-controller"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.jenkins_controller_cpu
  memory                   = var.jenkins_controller_memory
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  runtime_platform {
    cpu_architecture        = "ARM64"
    operating_system_family = "LINUX"
  }

  # depends_on = [null_resource.build_docker_image]
  tags = var.tags
}

resource "aws_ecs_service" "jenkins_controller_service" {
  name             = "jenkins_controller_service"
  cluster          = aws_ecs_cluster.jenkins.id
  task_definition  = aws_ecs_task_definition.jenkins_controller.arn
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  load_balancer {
    container_name   = var.jenkins_controller_container
    container_port   = 8080
    target_group_arn = aws_lb_target_group.jenkins.arn
  }

  network_configuration {
    subnets          = data.aws_subnets.main.ids
    security_groups  = [aws_security_group.jenkins_controller.id]
    assign_public_ip = true
  }

  depends_on = [aws_lb_listener.jenkins]

  tags = var.tags
}