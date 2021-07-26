module "state_bucket" {
  source = "../s3-module"

  bucket_name = "${var.project_prefix}-state-bucket-${data.aws_region.current.name}"
  kms_key_arn = aws_kms_key.backend_state_kms_key.arn
  tags        = var.tags
}

resource "aws_dynamodb_table" "state_lock_table" {
  name         = "${var.project_prefix}-state-table-${data.aws_region.current.name}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  tags         = var.tags

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_kms_key" "backend_state_kms_key" {
  enable_key_rotation = true
  description         = "KMS Key to encrypt terraform backend state bucket for ${var.project_prefix}."
  tags                = var.tags
}

resource "aws_kms_alias" "cicd_kms_key_alias" {
  name          = "alias/${var.project_prefix}-backend-state-kms-key"
  target_key_id = aws_kms_key.backend_state_kms_key.key_id
}