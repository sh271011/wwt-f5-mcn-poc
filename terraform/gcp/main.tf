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
    google = {
      source = "hashicorp/google"
      version = "4.33.0"
    }
  }
}

provider "volterra" {
  api_p12_file = var.api_p12_file
  url          = var.api_url
}

provider "google" {
  project = var.project_id
}

provider "kubernetes" {
   config_path = "./modules/k8s/kubeconfig-gcp.yaml"
 }

# Uncomment this section if you need to create a new namespace
# module "volterra-namespace" {
#   source = "./modules/volterra-namespace"
#   name   = var.name
# }

module "volterra-vpc" {
  source                = "./modules/volterra-vpc"
      gcp_regions        = [var.gcp_regions_a, var.gcp_regions_b]
      gcp_cidrs          = [var.gcp_cidr_one, var.gcp_cidr_two]
      gcp_credential_name = var.gcp_credential_name
      name               = var.name
      namespace          = var.namespace
      url                = var.api_url
      api_p12_file       = var.api_p12_file
      instance_type      = var.instance_type
}

module "k8s" {
source       = "./modules/k8s"
k8snamespace = var.k8snamespace
nodePort     = var.nodePort
}

module "volterra-lb" {
source                = "./modules/volterra-lb"
# uncomment this if you are creating namespace during deploy
#   depends_on = [
#     module.volterra-namespace
#   ]

originpool_name       = var.originpool_name
originpool_namespace  = var.namespace
origin_service_name   = format("%s.%s", module.k8s.k8s_app_name, module.k8s.k8s_namespace_name)
origin_service_tenant = var.origin_service_tenant
healthcheck_name      = var.healthcheck_name
vpc_site_name = var.vpc_site_name
}