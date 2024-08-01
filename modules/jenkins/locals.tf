locals {
  jenkins_agent_conf = templatefile("${path.module}/templates/clouds.ecs.yaml", {
    cluster_agent_fargate = aws_ecs_cluster.jenkins.arn
    region                = data.aws_region.current.name
    name                  = var.agent_container
    image                 = var.agent_image
    cpu                   = var.agent_cpu
    memory                = var.agent_memory
    log_group             = aws_cloudwatch_log_group.jenkins.name
    execution_role        = aws_iam_role.jenkins.arn
    security_groups       = aws_security_group.agent.id
    subnets               = join(",", data.aws_subnets.main.ids)
  })
}