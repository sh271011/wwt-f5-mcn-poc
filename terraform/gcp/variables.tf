variable "project_id" {
    type = string
    default = "gcp-atcpoc0006319-10008495"
    description = "Project ID for IAM user deployment"
}

// Required Variable
variable "gcp_regions_a" {
  type        = string
  description = "GCP Region A: "
  default     = "us-east1"
}

variable "gcp_regions_b" {
  type        = string
  description = "GCP Region B: "
  default     = "us-east4"
}

variable "gcp_zone_names_a" {
  type        = string
  description = "GCP Zone A: "
  default     = "us-east1-a"
}

variable "gcp_zone_names_b" {
  type        = string
  description = "GCP Zone B: "
  default     = "us-east1-b"
}

variable "gcp_zone_names_c" {
  type        = string
  description = "GCP Zone C: "
  default     = "us-east1-c"
}

variable "gcp_zone_names_4a" {
  type        = string
  description = "GCP Zone 4A: "
  default     = "us-east4-a"
}

variable "gcp_zone_names_4b" {
  type        = string
  description = "GCP Zone 4B: "
  default     = "us-east4-b"
}

variable "gcp_zone_names_4c" {
  type        = string
  description = "GCP Zone 4C: "
  default     = "us-east4-c"
}

// Required Variable
variable "api_p12_file" {
  default     = "./<your-api-creds-file>.p12"
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
}

// Required Variable
variable "tenant_name" {
  type        = string
  description = " This is your volterra Tenant Name:  https://<tenant_name>.console.ves.volterra.io/api"
  default     = "wwt-laas"
}
// Required Variable
variable "namespace" {
  type        = string
  description = " This is your volterra App Namespace"
  default     = "testdelme"
}
// Required Variable
variable "name" {
  type        = string
  description = " This is name for your deployment"
  default     = "tfdeploy"
}

// Required Variable
variable "api_url" {
  type        = string
  description = " This is your volterra API url"
  default     = "https://<your-tenant-url>/api"
}

# NETWORK
// Required Variable
variable "gcp_cidr_one" {
  description = "VNET Network CIDR"
  default     = "10.90.0.0/23"
}

variable "gcp_cidr_two" {
  description = "VNET Network CIDR"
  default     = "10.100.0.0/23"
}

variable "gcp_subnet_one" {
  type        = string
  description = "Subnet CIDRs"
  default = "10.90.0.0/24"
  }

variable "gcp_subnet_two" {
  type        = string
  description = "Subnet CIDRs"
  default = "10.100.0.0/24"
  }

variable "gcp_credential_name" {
  type = string
  description = "Name for the GCP Cloud Credential"
}

variable "instance_type" {
  type        = string
  description = "Instance type for the deployment"
  default     = "n1-standard-4"
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

// variable "originpool_namespace" {
//  type        = string
//  description = "Namespace for origin pool creation."
// }

variable "origin_service_tenant" {
  type        = string
  description = "K8S service tenant for deployed app."
}

variable "healthcheck_name" {
  type        = string
  description = "Name for healthcheck"
}

variable "k8snamespace" {
  type        = string
  description = "Name for new k8s namespace for creation."
}