resource "aws_s3_bucket" "s3Bucket" {
  bucket        = var.bucket_name
  acl           = "private"
  force_destroy = var.force_destroy
  tags          = var.tags

  versioning {
    enabled = var.versioning
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle_rule {
    enabled = var.enable_lifecycle
    expiration {
      days = var.enable_lifecycle ? var.expire_after_days : null
    }
  }

}

resource "aws_s3_bucket_public_access_block" "s3Bucket" {
  bucket                  = aws_s3_bucket.s3Bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
