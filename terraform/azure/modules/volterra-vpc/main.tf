terraform {
  required_providers {
    volterra = {
      source = "volterraedge/volterra"
      version = "0.11.9"
    }
  }
}

resource "volterra_cloud_credentials" "azure" {
  name        = var.azure_credential_name
  description = format("Azure credential will be used to create site %s", var.azure_credential_name)
  namespace   = "system"
  azure_client_secret {
    client_id = var.azure_client_id
    subscription_id = var.azure_subscription_id
    tenant_id = var.azure_tenant_id
    client_secret {
      clear_secret_info {
        url = "string:///${base64encode(var.azure_client_secret)}"
      }
    }
  }
}

resource "volterra_azure_vnet_site" "wwtatc-az-vnet" {
  name       = var.vnet_site_name
  namespace  = "system"
  azure_region = var.azure_region
  vnet {
    new_vnet {
      name = var.azure_vnet_name
      primary_ipv4 = var.primary_ipv4
    }
  }

  // One of the arguments from this list "default_blocked_services blocked_services" must be set
  default_blocked_services = true

  // One of the arguments from this list "aws_cred" must be set

  azure_cred {
    name      = volterra_cloud_credentials.azure.name
    namespace = "system"
  }
  resource_group = var.azure_resource_group
  machine_type = var.azure_machine_type
  // One of the arguments from this list "logs_streaming_disabled log_receiver" must be set
  logs_streaming_disabled = true

  // One of the arguments from this list "ingress_egress_gw voltstack_cluster ingress_gw" must be set

  ingress_egress_gw {

    azure_certified_hw = var.azure_hw_type

    az_nodes {
      azure_az = var.azure_az
      disk_size   = var.azure_disk_size

      inside_subnet {
        subnet_param {
          ipv4 = var.inside_subnet
        }
      }
      outside_subnet {
        subnet_param {
          ipv4 = var.outside_subnet
        }
      }
    }

    local_control_plane {
      // One of the arguments from this list "no_local_control_plane default_local_control_plane" must be set
      no_local_control_plane = true
    }
  }
}

resource "null_resource" "wait_for_azure_mns" {
  triggers = {
    depends = volterra_azure_vnet_site.wwtatc-az-vnet.id
  }
}

resource "volterra_tf_params_action" "apply_az_vnet" {
  depends_on       = [null_resource.wait_for_azure_mns]
  site_name        = var.vnet_site_name
  site_kind        = "azure_vnet_site"
  action           = "apply"
  wait_for_action  = true
  ignore_on_update = true
}

