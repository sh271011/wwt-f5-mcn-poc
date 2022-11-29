terraform {
  required_providers {
    volterra = {
      source = "volterraedge/volterra"
      version = "0.11.9"
    }
  }
}

resource "volterra_cloud_credentials" "aws" {
  name        = var.aws_credential_name
  description = format("AWS credential will be used to create site %s", var.aws_credential_name)
  namespace   = "system"
  aws_secret_key {
    access_key = var.aws_iam_access_key
    secret_key {
      clear_secret_info {
        url = "string:///${base64encode(var.aws_iam_secret_key)}"
      }
    }
  }
}

resource "volterra_aws_vpc_site" "wwtatc-aws-vpc" {
  name       = var.vpc_site_name
  namespace  = "system"
  aws_region = var.aws_region
  vpc {
    new_vpc {
      primary_ipv4 = var.primary_ipv4
    }
  }

  // One of the arguments from this list "default_blocked_services blocked_services" must be set
  default_blocked_services = true

  // One of the arguments from this list "aws_cred" must be set

  aws_cred {
    name      = volterra_cloud_credentials.aws.name
    namespace = "system"
  }
  instance_type =  var.aws_instance_type
  // One of the arguments from this list "logs_streaming_disabled log_receiver" must be set
  logs_streaming_disabled = true

  // One of the arguments from this list "ingress_egress_gw voltstack_cluster ingress_gw" must be set

  ingress_egress_gw {
    allowed_vip_port {
      // One of the arguments from this list "use_http_port use_https_port use_http_https_port custom_ports" must be set
      use_http_https_port = true
    }

    aws_certified_hw = var.aws_hw_type

    az_nodes {
      aws_az_name = var.aws_az
      reserved_inside_subnet = false
      disk_size   = var.aws_disk_size

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

resource "null_resource" "wait_for_aws_mns" {
  triggers = {
    depends = volterra_aws_vpc_site.wwtatc-aws-vpc.id
  }
}

resource "volterra_tf_params_action" "apply_aws_vpc" {
  depends_on       = [null_resource.wait_for_aws_mns]
  site_name        = var.vpc_site_name
  site_kind        = "aws_vpc_site"
  action           = "plan"
  wait_for_action  = true
  ignore_on_update = true
}

