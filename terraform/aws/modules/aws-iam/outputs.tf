output "iam_access_key_id" {
  description = "The access key ID"
  value       = aws_iam_access_key.volterra.id
}

output "iam_access_key_secret" {
  description = "The access key secret"
  value       = aws_iam_access_key.volterra.secret
  sensitive   = true
}

output "iam_user_name" {
    description = "Name of user created"
    value = aws_iam_user.f5serviceaccount.name
}