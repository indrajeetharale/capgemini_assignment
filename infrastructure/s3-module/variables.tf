variable "bucket_name" {
}
// Change this to false for real usecase, for assignment I am keeping it true for easy infra tear down
variable "force_destroy" {
  default = true
}
variable "versioning" {
  default = true
}
variable "enable_lifecycle" {
  default = false
}
variable "expire_after_days" {
  default = "365"
}
variable "kms_key_arn" {
  description = "KMS Key arn to encrypt bucket"
}
variable "tags" {
}