terraform {
  required_providers {
    volterra = {
      source = "volterraedge/volterra"
      version = "0.11.9"
    }
  }
}

resource "volterra_namespace" "volterra_ns" {
  name = var.name
}

resource "time_sleep" "wait_n_seconds" {
  depends_on = [
    volterra_namespace.volterra_ns
  ]
  create_duration = var.namespace_create_timeout
}

resource "null_resource" "next" {
  depends_on = [
    time_sleep.wait_n_seconds
  ]
}