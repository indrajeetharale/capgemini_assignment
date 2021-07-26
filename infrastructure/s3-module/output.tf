output "id" {
  description = "Bucket ID"
  value       = aws_s3_bucket.s3Bucket.id
}
output "bucket" {
  description = "Bucket Name"
  value       = aws_s3_bucket.s3Bucket.bucket
}
output "arn" {
  description = "Bucket ARN"
  value       = aws_s3_bucket.s3Bucket.arn
}

output "bucket_domain_name" {
  description = "Bucket Domain Name"
  value       = aws_s3_bucket.s3Bucket.bucket_domain_name
}