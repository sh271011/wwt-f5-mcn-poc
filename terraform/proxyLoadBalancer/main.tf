terraform {
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = "0.11.9"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.12.1"

    }
  }
}

provider "volterra" {
  api_p12_file = var.api_p12_file
  url          = var.api_url
}

provider "kubernetes" {
   config_path = "./ves_mcn-walkthrough_mcn-walkthrough-vk8s.yaml"
 }

resource "kubernetes_config_map" "nginx_configmap" {
  metadata {
    name = "nginx-conf"
    namespace = var.k8snamespace
  }
  data = {
    "nginx-proxy.yaml" = file("${path.module}/nginx-proxy.yaml")
  }
}

module "volterra-lb" {
source                = "./modules/volterra-lb"
originpool_name       = var.originpool_name
originpool_namespace  = var.namespace
origin_service_name   = format("%s.%s", module.k8s.k8s_namespace_name)
origin_service_tenant = var.origin_service_tenant
healthcheck_name      = var.healthcheck_name
vpc_site_name = var.vpc_site_name
}

# Delete DNS subdomain pre-req for HTTP LB
resource "volterra_dns_domain" "proxy_domain" {
  name      = var.domainname
  namespace = var.namespace

  // One of the arguments from this list "verification_only volterra_managed route53" must be set
  volterra_managed = true
}

# Create HTTP LB
resource "volterra_http_loadbalancer" "proxy_lb" {
  name = var.lb_name
  namespace = var.namespace
  advertise_on_public_default_vip = true
  disable_api_definition = true
  no_challenge = true
  service_policies_from_namespace = true
  domains = [var.domainname]
  https_auto_cert {
    http_redirect = true
    add_hsts = false
  }
  default_route_pools {
    pool {
      name = var.originpool_name
      namespace = var.namespace
    }
  }
  app_firewall {
    namespace = var.namespace
    name = "default"
    tenant = var.tenant_name
  }
}

