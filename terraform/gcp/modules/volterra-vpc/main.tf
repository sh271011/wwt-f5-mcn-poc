terraform {
  required_providers {
    volterra = {
      source = "volterraedge/volterra"
      version = "0.11.9"
    }
  }
}

data google_compute_zones available {
  count  = length(var.gcp_regions)
  region = var.gcp_regions[count.index]
}

resource "volterra_cloud_credentials" "gcp" {
  name        = var.gcp_credential_name
  description = format("GCP credential will be used to create site %s", var.gcp_credential_name)
  namespace   = "system"
   gcp_cred_file {
    credential_file {
      clear_secret_info {
        url = format("string:///%s", base64encode(file("${path.root}/volterrakey.json")))
      }
    }
   }
}

resource "volterra_gcp_vpc_site" "wwtatc-gcp-vpc" {
  count  = length(var.gcp_regions)
  name      = format("%s-vpc-site-%02d", var.name, count.index)
  namespace = "system"

  cloud_credentials {
    name      = volterra_cloud_credentials.gcp.name
    namespace = "system"
  }

  gcp_region    = var.gcp_regions[count.index]
  instance_type = var.instance_type

  logs_streaming_disabled = true

  voltstack_cluster {
    gcp_certified_hw = "gcp-byol-voltstack-combo"

    gcp_zone_names = data.google_compute_zones.available[count.index].names

# only 1 and three are supported deployment types
    node_number = "1"

    site_local_network {
      new_network_autogenerate {
        autogenerate = true
      }
    }

    # THIS NEEDS TO BE A LIST OF STRINGS
    site_local_subnet {
      new_subnet {
        subnet_name  = format("%s-subnet-%02d", var.name, count.index)
        primary_ipv4 = var.gcp_cidrs[count.index]
      }
    }


    no_network_policy        = true
    no_forward_proxy         = true
    no_outside_static_routes = true
    no_k8s_cluster           = true
    #default_storage          = ""
    # k8s_cluster {
    #   namespace = "system"
    #   name      = volterra_k8s_cluster.cluster.name
    # }
  }

}

resource "volterra_tf_params_action" "apply_gcp_vpc" {
  count           = length(var.gcp_regions)
  site_name        = volterra_gcp_vpc_site.wwtatc-gcp-vpc[count.index].name
  site_kind        = "gcp_vpc_site"
  action           = "apply"
  wait_for_action  = true
  ignore_on_update = true
}

