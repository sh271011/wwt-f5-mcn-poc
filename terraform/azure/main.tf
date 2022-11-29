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
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.19.1"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "2.27.0"
    }
  }
}

provider "volterra" {
  api_p12_file = var.api_p12_file
  url          = var.api_url
}

# provider "azurerm" {
#   features {}
#   client_id = ""
#   subscription_id = ""
#   tenant_id = ""
#   client_secret = ""
# }

# provider "azuread" {
# }

 provider "kubernetes" {
   config_path = "./modules/k8s/kubeconfig-azure-atcbld.yaml"
 }

# Uncomment this section if you need to create a new namespace
# module "volterra-namespace" {
#   source = "./modules/volterra-namespace"
#   name   = var.name
# }

# module "azure-iam" {
#   source     = "./modules/azure-iam"
#   azure_tenant_id = var.azure_tenant_id
#   azure_app_role_name = var.azure_app_role_name
#   azuread_application_display_name = var.azuread_application_display_name
# }

module "volterra-vpc" {
  source                = "./modules/volterra-vpc"
  azure_tenant_id   = var.azure_tenant_id
  azure_subscription_id    = var.azure_subscription_id
  azure_client_id    = var.azure_client_id
  azure_credential_name = var.azure_credential_name
  azure_client_secret = var.azure_client_secret
  vnet_site_name         = var.vnet_site_name
  azure_region            = var.azure_region
  azure_machine_type     = var.azure_machine_type
  azure_hw_type           = var.azure_hw_type
  azure_az                = var.azure_az
  azure_resource_group    = var.azure_resource_group
  azure_vnet_name         = var.azure_vnet_name
  azure_disk_size         = var.azure_disk_size
  primary_ipv4          = var.primary_ipv4
  inside_subnet         = var.inside_subnet
  outside_subnet        = var.outside_subnet
}

module "k8s" {
  source       = "./modules/k8s"
  k8snamespace = var.k8snamespace
  nodePort     = var.nodePort
 }

module "volterra-lb" {
  source                = "./modules/volterra-lb"
  # Uncomment this if creating new namespace and not reusing existing namespace to keep from erroring out.
  # depends_on = [
  #   module.volterra-namespace
  # ]
  originpool_name       = var.originpool_name
  originpool_namespace  = var.originpool_namespace # module.volterra-namespace.volterra_namespace_name - Use this value if creating new namespace
  origin_service_name   = format("%s.%s", module.k8s.k8s_app_name, module.k8s.k8s_namespace_name)
  origin_service_tenant = var.origin_service_tenant
  healthcheck_name      = var.healthcheck_name
  vpc_site_name = var.vpc_site_name
}