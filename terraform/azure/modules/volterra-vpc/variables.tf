variable "vnet_site_name" {
    type = string
    description = "Name for VNET site"
}

variable "azure_client_id" {
  type        = string
  description = "Client ID for your Azure service principal"
}

variable "azure_client_secret" {
  type        = string
  description = "Client Secret (alias password) for your Azure service principal"
}

variable "azure_subscription_id" {
  type        = string
  description = "Subscription ID for your Azure service principal"
}

variable "azure_tenant_id" {
  type        = string
  description = "Tenant ID for your Azure service principal"
}

variable "azure_region" {
  type        = string
  description = "Azure Region where Site will be created"
  validation {
    condition = contains(["centralus", "eastus", "eastus2", "westus", "westus2", "northcentralus", "southcentralus", "westcentralus", "westeurope", "northeurope", "southeastasia", "eastasia", "japaneast", "japanwest", "brazilsouth", "australiaeast", "australiasoutheast", "southindia", "centralindia", "westindia", "canadacentral", "canadaeast", "uksouth", "ukwest", "westcentralus", "westeurope", "westus", "westus2"], var.azure_region)
    error_message = "Invalid Azure Region. Valid regions are: centralus, eastus, eastus2, westus, westus2, northcentralus, southcentralus, westcentralus, westeurope, northeurope, southeastasia, eastasia, japaneast, japanwest, brazilsouth, australiaeast, australiasoutheast, southindia, centralindia, westindia, canadacentral, canadaeast, uksouth, ukwest, westcentralus, westeurope, westus, westus2"
  }
}

variable "azure_az" {
  type        = string
  description = "Azure Availability Zone in which the site will be created"
}

variable "primary_ipv4" {
  type = string
  description = "Primary Vnet address space"
}

variable "inside_subnet" {
  type = string
  description = "Inside subnet in CIDR notation"
}

variable "outside_subnet" {
  type = string
  description = "Outside subnet in CIDR notation"
}

variable "azure_credential_name" {
  type = string
}

variable "azure_resource_group" {
  type        = string
  description = "Azure resource group where you want the site objects to be deployed, this has to be a new resource group"
}

variable "azure_machine_type" {
  type        = string
  description = "Azure Vnet Site machine type"
  default     = "Standard_D3_v2"
}

variable "azure_vnet_name" {
  type        = string
  description = "Azure Vnet Name"
}

variable "azure_disk_size" {
  type        = number
  description = "Disk size in GiB"
  default     = 80
}

variable "azure_hw_type" {
    type = string
    description = "Name of the Azure certified HW type"
    default = "azure-byol-multi-nic-voltmesh"
}