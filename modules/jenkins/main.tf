data "aws_region" "current" {}

data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_subnets" "main" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

locals {
  jenkins_agent_conf = templatefile("${path.module}/templates/clouds.ecs.yaml", {
    cluster_agent_fargate = aws_ecs_cluster.jenkins.arn
    cluster_agent_region  = data.aws_region.current.name
    retention_timeout     = var.agent_retention_timeout
    name                  = var.jenkins_agent_container
    image                 = var.jenkins_agent_image
    cpu                   = var.jenkins_agent_cpu
    memory                = var.jenkins_agent_memory
    execution_role        = aws_iam_role.ecs_execution_role.arn
    security_groups       = aws_security_group.jenkins_controller.id
    subnets               = join(",", data.aws_subnets.main.ids)
  })
}

resource "local_file" "jenkins_agent_conf" {
  content  = local.jenkins_agent_conf
  filename = "${path.module}/jcasc/clouds.ecs.yaml"
}

resource "null_resource" "build_docker_image" {
  triggers = {
    src_hash   = file("${path.module}/templates/clouds.ecs.yaml")
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<EOF
      task build tag push
    EOF
  }

  depends_on = [local_file.jenkins_agent_conf]
}

resource "aws_cloudwatch_log_group" "ecs" {
  name = var.log_group
  tags = var.tags
}

