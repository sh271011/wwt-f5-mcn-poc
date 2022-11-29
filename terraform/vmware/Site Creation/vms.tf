# Create CentOS Desktop Workstation


resource "vcd_vapp_vm" "esx01" {
  vapp_name           = vcd_vapp.vapp.name
  name                = "esx01"
  computer_name       = "esx01"
    catalog_name        = "Platform Lab Base Templates"
    template_name       = "volterra-mcn-base-template"
    vm_name_in_template = "esx01"
    power_on            = "true"
    memory              = "32768"
    cpus                = 12
    cpu_cores           = "1"
    network {
    type               = "vapp"
    name               = vcd_vapp_network.Management.name
    ip_allocation_mode = "MANUAL"
        ip                 = "192.168.2.10"
        is_primary         = false
  }
  network {
    type               = "vapp"
    name               = vcd_vapp_network.Management.name
    ip_allocation_mode = "POOL"
        is_primary         = false
  }

  customization {
    enabled                      = false
    allow_local_admin_password   = false
    auto_generate_password       = false
    change_sid                   = false
    }
  depends_on = [vcd_vapp.vapp]
}


resource "vcd_vapp_vm" "Jumpbox-AD" {
  vapp_name           = vcd_vapp.vapp.name
  name                = "Jumpbox-AD"
  computer_name       = "AD"
    catalog_name        = "Platform Lab Base Templates"
    template_name       = "volterra-mcn-base-template"
    vm_name_in_template = "Jumpbox-AD"
    power_on            = "true"
    memory              = "6144"
    cpus                = 2
    cpu_cores           = "1"
    network {
    type               = "vapp"
    name               = vcd_vapp_network.Management.name
    ip_allocation_mode = "MANUAL"
        ip                 = "192.168.2.2"
        is_primary         = false
  }

  customization {
    enabled                      = true
    allow_local_admin_password   = false
    auto_generate_password       = false
    change_sid                   = false
    }
  depends_on = [vcd_vapp.vapp]
}


resource "vcd_vapp_vm" "vc" {
  vapp_name           = vcd_vapp.vapp.name
  name                = "vc"
  computer_name       = "vc"
    catalog_name        = "Platform Lab Base Templates"
    template_name       = "volterra-mcn-base-template"
    vm_name_in_template = "vc"
    power_on            = "true"
    memory              = "16384"
    cpus                = 4
    cpu_cores           = "1"
    network {
    type               = "vapp"
    name               = vcd_vapp_network.Management.name
    ip_allocation_mode = "MANUAL"
        ip                 = "192.168.2.4"
        is_primary         = false
  }

  customization {
    enabled                      = true
    allow_local_admin_password   = false
    auto_generate_password       = false
    change_sid                   = false
    }
  depends_on = [vcd_vapp.vapp]
}
