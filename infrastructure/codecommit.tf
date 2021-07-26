resource "aws_codecommit_repository" "example_repo" {
  repository_name = var.project_prefix
  description     = "Repo for ${var.project_prefix} project"
}