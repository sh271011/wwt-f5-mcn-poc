terraform {
  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "3.2.0"
    }
  }
  backend "local" {}
}
provider "vcd" {
  user                 = var.vcd_user
  password             = var.vcd_pass
  org                  = var.vcd_org
  vdc                  = var.vcd_dc
  url                  = var.vcd_url
  allow_unverified_ssl = var.vcd_allow_unverified_ssl
}
