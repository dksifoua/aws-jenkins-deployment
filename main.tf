module "jenkins" {
  source                  = "./modules/jenkins"
  jenkins_cpu             = 512
  jenkins_image           = "dksifoua/jenkins:latest"
  jenkins_memory          = 1024
  vpc_id                  = "vpc-cbef96b6"
  jenkins_container       = "jenkins-controller"
  log_group               = "ecs/jenkins"
  agent_retention_timeout = 1
  agent_container         = "jenkins-agent"
  agent_cpu               = 512
  agent_image             = "jenkins/inbound-agent"
  agent_memory            = 1024
  tags = {
    Application = "Jenkins"
    Owner       = "Dimitri"
  }
}