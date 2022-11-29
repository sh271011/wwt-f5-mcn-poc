terraform {
  required_providers {
    volterra = {
      source = "volterraedge/volterra"
      version = "0.11.9"
    }
  }
}

resource "volterra_healthcheck" "azure_app3_healthcheck" {
  name      = var.healthcheck_name
  namespace = var.originpool_namespace

  // One of the arguments from this list "http_health_check tcp_health_check" must be set

  http_health_check {
    // One of the arguments from this list "use_origin_server_name host_header" must be set
    use_origin_server_name = true
    path                   = "/"
    use_http2                 = false
  }
  healthy_threshold   = 3
  interval            = 15
  timeout             = 3
  unhealthy_threshold = 1
}

resource "volterra_origin_pool" "azure_originpool" {
  name                   = var.originpool_name
  namespace              = var.originpool_namespace
  endpoint_selection     = "LOCAL_PREFERRED"
  loadbalancer_algorithm = "LB_OVERRIDE"

  origin_servers {
    // One of the arguments from this list "public_ip public_name private_name custom_endpoint_object vn_private_name private_ip k8s_service consul_service vn_private_ip" must be set

    k8s_service {
        service_name = var.origin_service_name
        site_locator {
          site {
          tenant = var.origin_service_tenant
          namespace = "system"
          name = var.vpc_site_name
          }
        }
      inside_network =  false
      outside_network = true
    }
  }

  port = "80"

  // One of the arguments from this list "no_tls use_tls" must be set
  no_tls = true

  healthcheck {
    tenant = var.origin_service_tenant
    namespace = var.originpool_namespace
    name = var.healthcheck_name
  }
}