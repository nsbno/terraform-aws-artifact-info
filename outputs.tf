output "version" {
  description = "The artifacts version."
  value       = data.aws_ssm_parameter.version
}

output "location" {
  description = "The location of the artifact. Typically the S3 Bucket name or the ECR Registry URI."
  value       = data.aws_ssm_parameter.version
}

output "path" {
  description = "Where the artifact is stored. Typically an S3 prefix or an ECR Repository name."
  value       = data.aws_ssm_parameter.version
}
