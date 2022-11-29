variable "vcd_user" {
  type        = string
  description = "vCD user"
  sensitive = true
  default = ""
}

variable "vcd_pass" {
  type        = string
  description = "vCD password"
  sensitive = true
  default = ""
}

variable "vcd_org" {
  type        = string
  description = "The vCD Org to place the vApp in"
  default     = "vCD-Sand"
}

variable "vcd_dc" {
  type        = string
  description = "Datacenter to place the vApp in"
  default     = "vCD-Sand-vApps"
}

variable "vcd_url" {
  type        = string
  description = "vCD URL"
  default     = "https://<your-vcloud-url>/api"
}

variable "vcd_allow_unverified_ssl" {
  type        = string
  description = "Allow unverified vCD cert"
  default     = "true"
}
