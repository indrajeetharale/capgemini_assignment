variable "project_prefix" {
  description = "Identifier for project related resources"
  default     = "spring-boot-react-example"
}
variable "tags" {
  default = {
    PROJECT       = "spring-boot-react-example",
    BUSINESS_UNIT = "Recruitement",
    CREATED_BY    = "Indrajeet Harale"
  }
}

variable "enable_cicd_alert" {
  description = "true to create CICD alerting infrastructure, false otherwise"
  type        = bool
  default     = true
}

variable "aws_region" {
  description = "AWS region to use for infrastructure deployment"
}

variable "path_to_public_key" {
  description = "Path to your SSH public key to use for access to deployment server (EC2)"
}
variable "your_ip_address" {
  description = "Your laptop's ip address to be able to access deployment server over ssh and http"
}