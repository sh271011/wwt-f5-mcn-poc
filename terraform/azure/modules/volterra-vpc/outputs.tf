output "vnet_inside_addr" {
  description = "Vnet inside address"
  value = var.inside_subnet
}

output "vnet_outside_addr" {
  description = "Vnet outside address"
  value = var.outside_subnet
}