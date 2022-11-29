output "sp_id" {
  value = "${azuread_service_principal.volterra_azure_app.id}"
}

output "azure_client_id" {
  value = "${azuread_service_principal.volterra_azure_app.application_id}"
}

output "azure_client_secret" {
  sensitive = true
  value     = "${azuread_service_principal_password.f5_sp_password.value}"
}