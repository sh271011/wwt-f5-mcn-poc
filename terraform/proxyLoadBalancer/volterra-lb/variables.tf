variable originpool_name {
  type = string
  description = "Name for origin pool creation."
}

variable originpool_namespace {
  type = string
  description = "Namespace for origin pool creation."
}

variable origin_service_name {
  type = string
  description = "K8S service name for deployed app."
}

variable origin_service_tenant {
  type = string
  description = "K8S service tenant for deployed app."
}

variable healthcheck_name {
  type = string
  description = "Name for healthcheck"
}

variable vpc_site_name {
  type = string
  description = "Name for VPC site"
}