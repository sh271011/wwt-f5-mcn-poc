output "gcp_secret_key_private" {
  value = "${google_service_account_key.mykey.private_key}"
  sensitive = true
}

output "gcp_secret_key_public" {
  value = "${google_service_account_key.mykey.public_key}"
  sensitive = true
}

output "gcp_key_location" {
  value = local_file.service_account.filename
}