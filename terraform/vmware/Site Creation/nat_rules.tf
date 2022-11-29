resource "vcd_vapp_nat_rules" "vapp-nat" {
  vapp_id    = vcd_vapp.vapp.id
  network_id = vcd_vapp_network.Management.id
  nat_type   = "portForwarding"
  rule {
    external_port   = "3389"
    forward_to_port = "3389"
    protocol        = "TCP"
    vm_nic_id       = "0"
    vm_id           = vcd_vapp_vm.Jumpbox-AD.id
  }
  rule {
    external_port   = "8443"
    forward_to_port = "443"
    protocol        = "TCP"
    vm_nic_id       = "0"
    vm_id           = vcd_vapp_vm.vc.id
  }
  rule {
    external_port   = "443"
    forward_to_port = "443"
    protocol        = "TCP"
    vm_nic_id       = "0"
    vm_id           = vcd_vapp_vm.esx01.id
  }
}
