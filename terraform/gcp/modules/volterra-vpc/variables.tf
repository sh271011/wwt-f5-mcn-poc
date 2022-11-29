variable "name" {}
variable "namespace" {}
variable "url" {}
variable "api_p12_file" {}
variable "instance_type" {}
variable "gcp_cidrs" {
    type = list(string)
}
variable "gcp_regions"{
    type = list(string)
}

variable "gcp_credential_name" {}