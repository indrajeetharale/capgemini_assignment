# Artifact buckets for CodePipeline
module "codepipeline_bucket" {
  source = "./s3-module"

  bucket_name = "${var.project_prefix}-codepipeline-artifact-store"
  kms_key_arn = aws_kms_key.cicd_kms_key.arn
  tags        = var.tags
}


