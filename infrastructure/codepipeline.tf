resource "aws_codepipeline" "codepipeline" {
  name     = "${var.project_prefix}-codepipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  tags = var.tags

  artifact_store {
    location = module.codepipeline_bucket.bucket
    type     = "S3"
    encryption_key {
      id   = aws_kms_key.cicd_kms_key.arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source"]

      configuration = {
        RepositoryName = aws_codecommit_repository.example_repo.repository_name
        BranchName     = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source"]
      output_artifacts = ["build"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.codebuild.name
      }
    }
  }

//  stage {
//    name = "Deploy"
//
//    action {
//      name            = "DeployToECS"
//      category        = "Deploy"
//      owner           = "AWS"
//      provider        = "CodeDeployToECS"
//      input_artifacts = ["demo-docker-build"]
//      version         = "1"
//
//      configuration = {
//        ApplicationName                = aws_codedeploy_app.demo.name
//        DeploymentGroupName            = aws_codedeploy_deployment_group.demo.deployment_group_name
//        TaskDefinitionTemplateArtifact = "demo-docker-build"
//        AppSpecTemplateArtifact        = "demo-docker-build"
//      }
//    }
//  }
}