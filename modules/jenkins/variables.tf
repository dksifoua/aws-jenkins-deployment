variable "vpc_id" {
  description = "The vpc id where to deploy jenkins"
  type        = string
}

variable "jenkins_controller_image" {
  description = "The jenkins controller docker image"
  type        = string
}

variable "jenkins_controller_container" {
  description = "The jenkins controller container name"
  type        = string
}

variable "jenkins_controller_cpu" {
  description = "The jenkins controller cpu quantity"
  type        = number
}

variable "jenkins_controller_memory" {
  description = "The jenkins controller memory quantity"
  type        = number
}

variable "jenkins_agent_image" {
  description = "The jenkins agent docker image"
  type        = string
}

variable "jenkins_agent_container" {
  description = "The jenkins agent container name"
  type        = string
}

variable "jenkins_agent_cpu" {
  description = "The jenkins agent cpu quantity"
  type        = number
}

variable "jenkins_agent_memory" {
  description = "The jenkins agent memory quantity"
  type        = number
}

variable "log_group" {
  description = "CloudWatch log group name"
  type        = string
}

variable "agent_retention_timeout" {
  description = "Jenkins ecs agent retention timeout"
  type        = number
}

variable "tags" {
  description = "An object of tag in key value pair"
  type        = map(any)
}