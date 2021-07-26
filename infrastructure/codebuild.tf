resource "aws_codebuild_project" "codebuild" {

  name          = var.project_prefix
  description   = "CodeBuild project for ${var.project_prefix} project"
  build_timeout = "30"
  service_role  = aws_iam_role.codebuild_role.arn

  tags = var.tags

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:1.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "TF_VERSION"
      value = "0.13.5"
    }
    environment_variable {
      name  = "ENV_VAR"
      value = "dummy"
    }

    //    environment_variable {
    //      name = "deployment_role_arn"
    //      value = var.deployment_role_arn
    //    }
  }
}