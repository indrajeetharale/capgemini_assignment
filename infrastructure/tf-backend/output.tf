output "bucket" {
  description = "Backend bucket for terraform state file"
  value       = module.state_bucket.id
}

output "key" {
  description = "Key name inside which remote state file will be stored"
  value       = "remote-state"
}

output "region" {
  description = "Region"
  value       = data.aws_region.current.name
}

output "dynamodb_table" {
  description = "State lock table for terraform backend"
  value       = aws_dynamodb_table.state_lock_table.id
}