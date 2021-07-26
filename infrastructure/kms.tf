resource "aws_kms_key" "cicd_kms_key" {
  enable_key_rotation = true
  description         = "KMS Key to encrypt objects related to CICD pipeline of ${var.project_prefix}."
  tags                = var.tags
}

resource "aws_kms_alias" "cicd_kms_key_alias" {
  name          = "alias/${var.project_prefix}-cicd-kms-key"
  target_key_id = aws_kms_key.cicd_kms_key.key_id
}