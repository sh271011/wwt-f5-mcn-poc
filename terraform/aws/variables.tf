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

variable "username" {
  type        = string
  description = "Name for new AWS service account."
}

variable "rolename" {
  type        = string
  description = "Name for AWS role"
}

variable "policyname" {
  type        = string
  description = "Name for AWS policy"
}

variable "vpc_site_name" {
  type        = string
  description = "Name for VPC site"
}

variable "aws_region" {
  type        = string
  description = "AWS Region where Site will be created"
}

variable "aws_instance_type" {
  type        = string
  description = "AWS instance type used for the Volterra site (Enter for default)"
  default     = "t3.2xlarge"
}

variable "aws_hw_type" {
  type        = string
  description = "Name of the AWS certified HW type (Enter for default)"
  default     = "aws-byol-multi-nic-voltmesh"
}

variable "aws_disk_size" {
  type        = number
  description = "Disk size in GiB (80 default)"
  default     = 80
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

variable "aws_az" {
  type        = string
  description = "AWS Availability Zone e.g. us-east-1a"
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

