data "vsphere_datacenter" "datacenter" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.clustername
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_resource_pool" "default" {
  name          = format("%s%s", data.vsphere_compute_cluster.cluster.name, "/Resources")
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_host" "host" {
  name          = var.vsphere_host_one
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "inside" {
  name          = var.inside_network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "outside" {
  name          = var.outside_network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

## Deployment of VM from Remote OVF
resource "vsphere_virtual_machine" "vmFromRemoteOvf" {
  name                 = var.nodenames["nodeone"]
  datacenter_id        = data.vsphere_datacenter.datacenter.id
  datastore_id         = data.vsphere_datastore.datastore.id
  host_system_id       = data.vsphere_host.host.id
  resource_pool_id     = data.vsphere_resource_pool.default.id

  num_cpus = var.cpus
  memory   = var.memory
  guest_id = var.guest_type

  network_interface {
    network_id   = data.vsphere_network.outside.id
    adapter_type = "vmxnet3"
  }
  network_interface {
    network_id   = data.vsphere_network.inside.id
    adapter_type = "vmxnet3"
  }
  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  ovf_deploy {
    allow_unverified_ssl_cert = true
    local_ovf_path            = var.xcsovapath
    disk_provisioning         = "thin"
    ip_protocol               = "IPV4"
    ip_allocation_policy      = "STATIC_MANUAL"
    ovf_network_map = {
      "OUTSIDE" = data.vsphere_network.outside.id
      "REGULAR" = data.vsphere_network.inside.id
    }
  }
  vapp {
    properties = {
      "guestinfo.ves.certifiedhardware" = var.certifiedhardware,
      "guestinfo.hostname"              = var.nodenames["nodeone"],
      "guestinfo.interface.0.name"      = "eth0",
      "guestinfo.dns.server.0"          =  var.dnsservers["primary"],
      "guestinfo.interface.0.dhcp"      = "yes",
      "guestinfo.interface.0.role"      = "public",
      "guestinfo.ves.adminpassword"     = var.node_password,
      "guestinfo.ves.regurl"            = "ves.volterra.io",
      "guestinfo.ves.clustername"       = var.nodenames["nodeone"],
      "guestinfo.ves.latitude"          = var.sitelatitude,
      "guestinfo.ves.longitude"         = var.sitelongitude,
      "guestinfo.ves.token"             = var.sitetoken
    }
  }
}
resource "volterra_registration_approval" "approvalone_a" {
  depends_on = [
    vsphere_virtual_machine.vmFromRemoteOvf
  ]
  cluster_name = var.nodenames["nodeone"]
  hostname     = var.nodenames["nodeone"]
  cluster_size = 1
  retry        = 5
  wait_time    = 120
  latitude     = var.sitelatitude
  longitude    = var.sitelongitude
}