output "vpc_inside_addr" {
  description = "VPC inside address"
  value = var.inside_subnet
}

output "vpc_outside_addr" {
  description = "VPC outside address"
  value = var.outside_subnet
}