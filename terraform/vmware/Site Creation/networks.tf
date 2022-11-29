# Create vApp Networks
resource "vcd_vapp_network" "Management" {
  name             = "Management"
  description      = ""
  vapp_name        = vcd_vapp.vapp.name
  gateway          = "192.168.2.1"
  netmask          = "255.255.255.0"
  dns1             = "127.0.0.1"
  dns2             = "10.255.0.1"
  dns_suffix       = "wwtatc.local"
  org_network_name = "vCD-SandOrgNet"
  static_ip_pool {
    start_address = "192.168.2.100"
    end_address   = "192.168.2.199"
  }
  dhcp_pool {
    start_address = "192.168.2.201"
    end_address   = "192.168.2.210"
  }
  depends_on = [vcd_vapp.vapp]
}

output Management_id {
  value = vcd_vapp_network.Management.id
}
