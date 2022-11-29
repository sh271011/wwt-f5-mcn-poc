variable "api_url" {
  default     = "https://<your-tenant-url>/api"
  description = "REQUIRED:  This is your volterra API url"
}

variable "api_p12_file" {
  default     = "./<your-api-creds-file>.p12"
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
}

variable "name" {
  type        = string
  description = "Name for new namespace, or queried existing namespace."
  validation {
    condition     = !can(regex("_", var.name))
    error_message = "Namespaces cannot include _ characters."
  }
}

variable "azuread_application_display_name" {
  type        = string
  description = "Display name for the application"
}

variable "azure_app_role_name" {
  type        = string
  description = "Display name for the application role"
}

variable "vpc_site_name" {
  type        = string
  description = "Name for VPC site"
}

variable "primary_ipv4" {
  type        = string
  description = "Primary VPC address space"
}

variable "inside_subnet" {
  type        = string
  description = "Inside subnet in CIDR notation"
}

variable "outside_subnet" {
  type        = string
  description = "Outside subnet in CIDR notation"
}

variable "k8snamespace" {
  type        = string
  description = "Name for new k8s namespace for creation."
}

variable "nodePort" {
  type        = number
  description = "NodePort for the service"
}

// variable "origin_service_name" {
//  type        = string
//  description = "K8S service name for deployed app."
// }

variable "originpool_name" {
  type        = string
  description = "Name for origin pool creation."
}

variable "originpool_namespace" {
 type        = string
 description = "Namespace for origin pool creation. Existing namespace within Volterra Cloud Console."
}

variable "origin_service_tenant" {
  type        = string
  description = "K8S service tenant for deployed app."
}

variable "healthcheck_name" {
  type        = string
  description = "Name for healthcheck"
}

variable "azure_hw_type" {
  type        = string
  description = "Azure hardware type"
  default     = "azure-byol-multi-nic-voltmesh"
}

variable "vnet_site_name" {
    type = string
    description = "Name for VNET site"
}

variable "azure_region" {
  type        = string
  description = "Azure Region where Site will be created"
  validation {
    condition = contains(["centralus", "eastus", "eastus2", "westus", "westus2", "northcentralus", "southcentralus", "westcentralus", "westeurope", "northeurope", "southeastasia", "eastasia", "japaneast", "japanwest", "brazilsouth", "australiaeast", "australiasoutheast", "southindia", "centralindia", "westindia", "canadacentral", "canadaeast", "uksouth", "ukwest", "westcentralus", "westeurope", "westus", "westus2"], var.azure_region)
    error_message = "Invalid Azure Region. Valid regions are: centralus, eastus, eastus2, westus, westus2, northcentralus, southcentralus, westcentralus, westeurope, northeurope, southeastasia, eastasia, japaneast, japanwest, brazilsouth, australiaeast, australiasoutheast, southindia, centralindia, westindia, canadacentral, canadaeast, uksouth, ukwest, westcentralus, westeurope, westus, westus2."
  }
}

variable "azure_machine_type" {
  type        = string
  description = "Azure Vnet Site machine type"
  default     = "Standard_D3_v2"
}

variable "azure_az" {
  type        = string
  description = "Azure Availability Zone in which the site will be created"
}

variable "azure_disk_size" {
  type        = number
  description = "Disk size in GiB"
  default     = 80
}

variable "azure_vnet_name" {
  type        = string
  description = "Azure Vnet Name"
}

variable "azure_resource_group" {
  type        = string
  description = "Azure resource group where you want the site objects to be deployed, this has to be a new resource group"
}

variable "azure_client_id" {
  type        = string
  description = "Azure client id"
}

variable "azure_tenant_id" {
  type        = string
  description = "Azure tenant id"
}

variable "azure_client_secret" {
  type        = string
  description = "Azure client secret"
}

variable "azure_subscription_id" {
  type        = string
  description = "Azure subscription id"
}

variable "azure_credential_name" {
  type        = string
  description = "Azure credential name"
}