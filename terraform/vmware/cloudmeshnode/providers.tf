terraform {
  required_version = ">= 0.13"
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.2.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.1.0"
    }
    volterra = {
      source = "volterraedge/volterra"
      version = "0.11.14"
    }
  }
}

provider "http" {
}


provider "vsphere" {
  user           = var.user
  password       = var.password
  vsphere_server = var.vsphere_server

  allow_unverified_ssl = true
}

provider "volterra" {
  api_p12_file = var.api_p12_file
  url          = var.api_url
}