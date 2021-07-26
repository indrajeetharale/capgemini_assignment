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

variable "aws_region" {
  default = "eu-central-1"
}